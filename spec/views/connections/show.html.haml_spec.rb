require 'rails_helper'

RSpec.describe "connections/show.html.haml" do

  before do
    assign :consultant_one, Consultant.new(full_name: 'Bob', primary_role: 'Dev')
    assign :consultant_two, Consultant.new(full_name: 'Master', primary_role: 'QA')
    render
  end

  it 'show two consultants' do
    expect(rendered).to have_text('Bob')
    expect(rendered).to have_text('Dev')
    expect(rendered).to have_text('Master')
    expect(rendered).to have_text('QA')
  end

end
