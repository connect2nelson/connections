class GithubActivity
	attr_reader :repo_name, :consultant

	def initialize(repo_name, consultant)
		@repo_name = repo_name
		@consultant = consultant
	end

	def ==(another_activity)
		self.repo_name == another_activity.repo_name && self.consultant == another_activity.consultant
	end

	def hash
        self.repo_name.hash 
	end

	def eql?(another_activity)
       return self == another_activity
	end

end
