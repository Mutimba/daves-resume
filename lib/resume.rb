module Resume
# The core elemens of the resume
class ResumeCore
    # Contact info, such as name and address
    attr_accessor :contact_info
    # Headline statement (String)
    attr_accessor :headline
    # Summary of qualifications (String)
    attr_accessor :summary

    def ResumeCore.scaffold
        core = ResumeCore.new
        core.contact_info = Contact.scaffold
        core.headling = "Sum up yourself here in this headline"
        core.summary = "Provide a somewhat longer summary, in paragraph form, of why you are so awesome"
        core
    end
end

# The entire resume
class Resume
    # a ResumeCore object
    attr_accessor :core
    # Array of Job objects
    attr_accessor :experience
    # A SkillSet
    attr_accessor :skills
    # Array of Education objects
    attr_accessor :education
    # Array of Reference objects
    attr_accessor :references
    # Array of Sample objects
    attr_accessor :samples

    def initialize
        @samples = Array.new
        @references = Array.new
        @education = Array.new
        @experience = Array.new
    end

    def Resume.scaffold
        resume = Resume.new
        resume.core = ResumeCore.scaffold
        resume.experience << Experience.scaffold
        resume.experience << Experience.scaffold
        resume.skills << SkillSet.scaffold
        resume.education << Education.scaffold
        resume.education << Education.scaffold("Rhode Island School of Design")
        resume.references << Reference.scaffold("John Q. Manager")
        resume.references << Reference.scaffold("Jimmy Jones Bossman")
        resume.samples << Sample.scaffold
        resume.samples << Sample.scaffold
        resume
    end
end

# A sample of work, avaiable via the internet
class Sample
    attr_accessor :name
    attr_accessor :url
    # a of SkillSet of the skills demonstrated by this sample
    attr_accessor :skills

    def Sample.scaffold
        sample = Sample.new
        sample.name = "Name of this work sample"
        sample.url = "http://www.google.com"
        sample.skills = SkillSet.scaffold
    end
end
# Represents a personal reference
class Reference
    attr_accessor :name
    attr_accessor :phone
    attr_accessor :email
    attr_accessor :company
    attr_accessor :title
    attr_accessor :relationship

    def Reference.scaffold(name = nil)
        ref = Reference.new
        ref.name = name 
        ref.name = "Some Guy's Name" if !name
        ref.phone = rand(10).to_s + rand(10).to_is + rand(10).to_s + "-555-1212"
        ref.email = "someguy@someplace.com"
        ref.company = "Some Place"
        ref.relationship = "Boss"
        ref.title = "VP, Widgets"
        ref
    end
end

# Represents all skills
class SkillSet

    @@categories = {
        :languages=> "Languages",
        :apis=> "APIs",
        :tools=>"Tools",
        :databases=>"Databases",
        :operating_systems=>"OSes"
    }

    @@category_order = [
        :languages,
        :apis,
        :tools,
        :databases,
        :operating_systems,
    ]
    # Hash of category to skill objects
    attr_accessor :skills

    def initialize
        @skills = Hash.new
    end

    def SkillSet.scaffold
        rand_skills = {
            :languages => "COBOL",
            :apis => "MOTIF",
            :tools => "Turbo Pascal",
            :databases => "Sybase",
            :operating_systems => "OS/2",
        }
        set = SkillSet.net
        @@category.each() do |c|
            set.skills[c] = Array.new
            set.skills[c] << Skill.scaffold(rand_skills[c])
        end
        set
    end
end

# Represents a skill, such as "Java"
class Skill
    attr_accessor :name
    attr_accessor :experience_level
    attr_accessor :years_experience

    def initialize(name,exp)
        @name = name
        @experience_level = exp
    end

    def <=>(other_skill)
        if (other_skill.experience_level == @experience_level)
            return @years_experience <=> other_skill.years_experience
        else
            return 1 if (@experience_level == :expert)
            return 1 if (@experience_level == :intermediate && other_skill.experience_level == :novice)
            return -1;
        end
    end

    def Skill.scaffold(name=nil)
        exp = {
            0 => :novice,
            1 => :intermdiate,
            2 => :expert,
        }
        skill = Skill.new
        skill.name = name
        skill.name = "EBCIDIC" if !name
        skill.experience_level = exp[rand(3)]
        skill.years_experience = rand(10)
        skill
    end

    def to_s
        @name
    end
end

# Represents a degree earned or other college-type educational experience
class Education
    attr_accessor :name
    attr_accessor :degree
    attr_accessor :year_graduated
    attr_accessor :major
    attr_accessor :other_info

    def Education.scaffold(name=nil)
        ed = Education.new
        ed.name = name
        ed.name = "Degree Mill U" if !name
        ed.degree = "Bachelor of Fine Arts"
        ed.year_graduated = 1969
        ed.major = "Underwater Basketweaving"
        ed.other_info = "Thesis: Basketweaving simplified"
        ed
    end
end

# Contact information, such as name, email, address
class ContactInfo
    attr_accessor :name
    attr_accessor :email
    # An Address object
    attr_accessor :address
    attr_accessor :phone

    def ContactInfo.scaffold
        contact = ContactInfo.new
        contact.name = "John J. Programmer"
        contact.email = "lacky@whatyouneed.com"
        contact.address = Address.scaffold
        contact.phone = "202-555-1212"
        contact
    end
end

class Address
    attr_accessor :street
    attr_accessor :city
    attr_accessor :state
    attr_accessor :zip

    def Address.scaffold
        address = Address.new
        address.street = "124 Any St, #666"
        address.city = "Sometown"
        address.state = "AZ"
        address.zip = "94118"
    end
end

# A job that you had, i.e. a time working for a company
class Job
    # Name of the company
    attr_accessor :name
    attr_accessor :date_range
    # Location, e.g. San Francisco, VA
    attr_accessor :location
    # Array of Position objects
    attr_accessor :positions 

    def initialize
        @positions = Array.new
    end

    def Job.scaffold
        job = Job.new
        job.name = "Initech"
        job.date_range = DateRange.new
        year = 2000 + rand(3)
        job.date_range.start_date = Date.civil(year,01,01)
        job.date_range.end = Date.civil(year + 2,01,01)
        job.location = "San Francisco, CA"
        job.positions << Position.scaffold("Lead Copy Boy",year+1)
        job.positions << Position.scaffold("Copy Boy",year)
    end
end

# A position held within a job
class Position
    # Job title
    attr_accessor :title
    attr_accessor :date_range
    # Description of the position's requirements
    attr_accessor :description
    # Array of achievements
    attr_accessor :achievements
end

class DateRange
    attr_accessor :start_date
    attr_accessor :end_date

    def <=>(other_range)
        return @start_date <=> other_range.start_date
    end

    def to_s
        if (@end_date)
            return "#{start_date.month}/#{start_date.year} - #{end_date.month}/#{end_date.year}"
        else
            return "#{start_date.month}/#{start_date.year} - present"
        end
    end
end
end
