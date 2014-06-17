require 'rails_helper'

RSpec.describe "connections/show.html.haml" do

  before do
    consultant_one = Consultant.new(full_name: 'Bob', primary_role: 'Dev', skills: {})
    consultant_two = Consultant.new(full_name: 'Master', primary_role: 'QA', skills: {})
    connection = Connection.new(consultant_one, consultant_two)
    allow(connection).to receive(:score).and_return(1.5)
    assign :consultant_one, consultant_one
    assign :consultant_two, consultant_two
    assign :connection, connection
    render
  end

  it 'show two consultants' do
    expect(rendered).to have_text('Bob')
    expect(rendered).to have_text('Dev')
    expect(rendered).to have_text('Master')
    expect(rendered).to have_text('QA')
  end

  it 'should show score' do
    expect(rendered).to have_text('1.5')
  end

end
