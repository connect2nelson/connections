require 'rails_helper'

RSpec.describe Consultant, :type => :model do
  it { should have_fields(:full_name, :skills) }
end
