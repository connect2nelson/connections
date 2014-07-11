require 'rails_helper'

RSpec.describe GithubRepository, :type => :model do

  describe 'attributes' do
    it 'should have attributes' do
      expect(subject).to have_fields(:repo_name, :languages)
    end

    it 'should have indexes' do
      expect(subject.index_specifications.size).to eq 1
      expect(subject.index_specifications.first.key[:repo_name]).to eq 1
      expect(subject.index_specifications.first.options[:unique]).to be true
    end

    it {should have_many(:github_events)}
  end

end
