class SkillType
  attr_reader :tech_skills, :consulting_skills

  def initialize
    @tech_skills = {'java' => 1, 'ruby' => 1, 'css' => 1, 'html' => 1, 'sql' => 1, 'mysql' => 1, 'cucumber' => 1, 'c#' => 1,
                    'css3' => 1, 'ruby on rails' => 1, 'sass/scss' => 1, 'ios' => 1, 'go' => 1, 'scala' => 1, 'groovy' => 1,
                    'capybara' => 1, 'php' => 1, 'html5' => 1, 'javascript' => 1, 'java application development' => 1,
                    'javaScript application development' => 1, 'ui development' => 1, 'ruby application development' => 1,
                    'c# application development' => 1, 'groovy application development' => 1}

    @testing_skills = {'c# test automation' => 1, 'groovy test automation' => 1, 'java test automation' => 1, 'load testing' => 1,
                      'manual/exploratory testing' => 1, 'mobile test automation - ios' => 1, 'performance testing' => 1,
                      'selenium-webdriver' => 1, 'test parallelization (seleniumgrid, etc)' => 1}

    @consulting_skills = {'problem solving' => 1, 'communication' => 1, 'teaching' => 1, 'presenting' => 1, 'questioning' => 1,
                          'facilitation' => 1, 'influence' => 1, 'planning' => 1, 'negotiation' => 1, 'innovating' => 1,
                          'system thinking' => 1, 'relationship building' => 1, 'establish & Cultivate Relationships' => 1,
                          'requirements analysis' => 1, 'feedback & coaching' => 1, 'project planning & resourcing' => 1,
                          'stakeholder management' => 1, 'iteration management' => 1, 'project management' => 1,
                          'storytelling & storyboarding' => 1}
  end

  def type_of(name)
    if @tech_skills.has_key? name
      return 'tech'
    elsif @testing_skills.has_key? name
      return 'testing'
    elsif @consulting_skills.has_key? name
      return 'consulting'
    else
      return ''
    end
  end

end