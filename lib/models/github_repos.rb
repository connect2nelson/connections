class GithubRepos
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
  end

  def repo_groups
    repo_groups = {}

    consultants.each do |consultant|

      GithubEvent.where(employee_id: consultant.employee_id).each do |event|
        repo_name = event.github_repository.repo_name

        if repo_groups.has_key? repo_name
          if repo_groups[repo_name].has_key? consultant
            repo_groups[repo_name][consultant] += 1
          else
            repo_groups[repo_name][consultant] = 1
          end
        else
          repo_groups[repo_name] = {consultant => 1}
        end
      end
    end

    repo_groups.each do |repo, consultant_contributions|
      repo_groups[repo] = sort_contributors_by_commits consultant_contributions
    end

    repo_groups
  end

  def sort_contributors_by_commits contributions
    sorted_contributions = contributions.sort_by{ |consultant, number_of_contributions| number_of_contributions}.reverse
    sorted_contributions.flatten.delete_if{|element| element.is_a? Numeric}
  end

end

