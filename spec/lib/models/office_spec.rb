require 'rails_helper'

describe Office do
  it 'should have consultants' do
    consultants = [Consultant.new]
    expect(Office.new(consultants).consultants).to eq consultants
  end
end

