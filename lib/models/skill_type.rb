class SkillType
  attr_reader :tech_skills, :consulting_skills

  def initialize
    @tech_skills = Set.new ['java', 'ruby', 'css' , 'html' , 'sql' , 'mysql' , 'cucumber' , 'c#',
                    'css3' , 'ruby on rails' , 'sass/scss' , 'ios' , 'go' , 'scala' , 'groovy' ,
                    'capybara' , 'php' , 'html5' , 'javascript' , 'java application development',
                    'javaScript application development' , 'ui development' , 'ruby application development' ,
                    'c# application development' , 'groovy application development' ]

    @testing_skills = Set.new ['c# test automation' , 'groovy test automation' , 'java test automation' , 'load testing' ,
                      'manual/exploratory testing' , 'mobile test automation - ios' , 'performance testing' ,
                      'selenium-webdriver' , 'test parallelization (seleniumgrid, etc)' ]

    @consulting_skills = Set.new ['problem solving' , 'communication' , 'teaching' , 'presenting' , 'questioning' ,
                          'facilitation' , 'influence' , 'planning' , 'negotiation' , 'innovating' ,
                          'system thinking' , 'relationship building' , 'establish & Cultivate Relationships' ,
                          'requirements analysis' , 'feedback & coaching' , 'project planning & resourcing' ,
                          'stakeholder management' , 'iteration management' , 'project management' ,
                          'storytelling & storyboarding' ]
  end

  def type_of(name)
    if @tech_skills.include? name
      return 'tech'
    elsif @testing_skills.include? name
      return 'testing'
    elsif @consulting_skills.include? name
      return 'consulting'
    else
      return ''
    end
  end

end