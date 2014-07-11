require 'rails_helper'

RSpec.describe GithubEvent, :type => :model do

  describe 'attributes' do
    it 'should have attributes' do
      expect(subject).to have_fields(:event_id, :employee_id, :type, :created_at)
    end

    it 'should have indexes' do
      expect(subject.index_specifications.size).to eq 1
      expect(subject.index_specifications.first.key[:event_id]).to eq 1
      expect(subject.index_specifications.first.options[:unique]).to be true
    end

    it {should belong_to(:github_repository)}
  end

end
