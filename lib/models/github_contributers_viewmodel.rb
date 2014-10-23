class GithubContributersViewModel
	attr_reader :consultants, :repo_name

	def initialize(consultants, repo_name)
		@consultants = consultants
		@repo_name = repo_name
	end
end