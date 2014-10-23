class GithubContributersViewModel
	attr_reader :repo_name, :consultant

	def initialize(repo_name, consultant)
		@repo_name = repo_name
		@consultant = consultant
	end

end