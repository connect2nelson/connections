require 'rails_helper'

describe GithubRepos do
  describe '.new' do
    it 'should have consultants' do
      consultants = [Consultant.new]
      expect(GithubRepos.new(consultants).consultants).to eq consultants
    end
  end

  describe '#repo_groups' do
    before do
      @first_repo = GithubRepository.create(:repo_name => "connections")
      @second_repo = GithubRepository.create(:repo_name => "grezha")
      @third_repo = GithubRepository.create(:repo_name => "swiftAgainstHumanity")

      @consultant = Consultant.new(:employee_id => "1")
      @another_consultant = Consultant.new(:employee_id => "2")
      @third_consultant = Consultant.new(:employee_id => "3")
      @consultants = [@consultant, @another_consultant]

      GithubEvent.create(:employee_id => @consultant.employee_id, :github_repository_id => @first_repo.id)
      GithubEvent.create(:employee_id => @consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @another_consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @another_consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @third_consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @third_consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @third_consultant.employee_id, :github_repository_id => @second_repo.id)
      GithubEvent.create(:employee_id => @third_consultant.employee_id, :github_repository_id => @third_repo.id)
      GithubEvent.create(:employee_id => @third_consultant.employee_id, :github_repository_id => @first_repo.id)

    end

    it 'should sort the hash of office repos by number of contributors' do
      repo_groups = GithubRepos.new(@consultants).repo_groups

      expect(repo_groups[0].repo_name).to eq(@second_repo.repo_name)
      expect(repo_groups[1].repo_name).to eq(@first_repo.repo_name)
    end

    it "should sort the github repos in order of how many people have contributed from" do 
      repo_groups = GithubRepos.new([@consultant, @another_consultant, @third_consultant]).repo_groups
      expect(repo_groups[0].repo_name).to eq(@second_repo.repo_name)
      expect(repo_groups[1].repo_name).to eq(@first_repo.repo_name)
      expect(repo_groups[2].repo_name).to eq(@third_repo.repo_name)
    end

    it 'should return a hash of the office repos with lists of consultants who committed to them' do
      repo_groups = GithubRepos.new(@consultants).repo_groups

      expect(repo_groups[0].consultants).to eq([@another_consultant, @consultant])
      expect(repo_groups[1].consultants).to eq([@consultant])
    end

    it "should rank consultants in order when multiple commits" do
      repo_groups = GithubRepos.new([@consultant, @another_consultant, @third_consultant]).repo_groups
      expect(repo_groups[0].consultants).to eq([@third_consultant, @another_consultant, @consultant])  
    end

  end
end
