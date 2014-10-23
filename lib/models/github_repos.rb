class GithubRepos
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
  end

  def repo_groups_unordered
    repo_groups_by_consultant_and_repo = {}
    repo_groups_by_consultant_and_repo.default = 0

    repo_groups = @consultants.map { |consultant| 
      GithubEvent.where(:employee_id => consultant.employee_id).map { |event|
        GithubActivity.new(event.github_repository.repo_name, consultant)
        }
      }.reduce(:+).reduce(repo_groups_by_consultant_and_repo) {|total, github_activity| 
        total[github_activity] = total[github_activity] + 1
        total
      }
      .reduce({}) {|total, (github_activity, occurrences)|
        repo_name = github_activity.repo_name
        consultant = github_activity.consultant
        if total[repo_name]
          total[repo_name][consultant]= occurrences
        else
          total[repo_name]= {consultant => occurrences}
        end
        total
      }
  end

  def repo_groups
    repo_groups_by_consultant_and_repo = {}
    repo_groups_by_consultant_and_repo.default = 0

    repo_groups = repo_groups_unordered

    repo_groups.each do |repo, consultant_contributions|
      repo_groups[repo] = sort_contributors_by_commits consultant_contributions
    end

    repo_groups.sort_by{|repo_name, consultants| consultants.length}.reverse
  end

  def sort_contributors_by_commits contributions
    sorted_contributions = contributions.sort_by{ |consultant, number_of_contributions| number_of_contributions}.reverse
    sorted_contributions.flatten.delete_if{|element| element.is_a? Numeric}
  end

end

