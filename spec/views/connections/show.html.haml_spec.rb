require 'rails_helper'

RSpec.describe "connections/show.html.haml" do

  before do
    assign :consultant_one, Consultant.new(full_name: 'Bob')
    assign :consultant_two, Consultant.new(full_name: 'Master')
    render
  end

  it 'show two consultants' do
    expect(rendered).to have_text('Bob')
    expect(rendered).to have_text('Master')
  end

end
