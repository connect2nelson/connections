require 'rails_helper'

RSpec.describe Sponsorship, :type => :model do

  describe 'attributes' do
    it { expect(subject).to have_fields(:sponsor_id, :sponsee_id) }

  end

end
