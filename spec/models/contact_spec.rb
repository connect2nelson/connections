require 'rails_helper'

RSpec.describe Contact, :type => :model do

  describe 'attributes' do
    it { expect(subject).to have_fields(:employee_id, :github_account) }

  end

end
