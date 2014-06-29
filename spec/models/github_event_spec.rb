require 'rails_helper'

RSpec.describe GithubEvent, :type => :model do

  describe 'attributes' do
    it { expect(subject).to have_fields(:event_id, :employee_id, :repo_name, :type, :languages, :created_at, :avatar) }
  end

end
