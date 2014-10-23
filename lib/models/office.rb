class Office
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
  end

  def name
    consultants.first.home_office
  end

  def top_skills
    Skillset.new(consultants).top_skill_names
  end

  def skill_groups
    Skillset.new(consultants).skill_groups
  end

  def git_repo_groups
    GithubRepos.new(consultants).repo_groups
  end

  def sponsorship_network
    SponsorshipService.get_network_json_for @consultants
  end
end

