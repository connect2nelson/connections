require 'rails_helper'

RSpec.describe "connections/show.html.haml" do

  before do
    consultant_one = Consultant.new(full_name: 'Bob', primary_role: 'Dev', skills: {})
    consultant_two = Consultant.new(full_name: 'Master', primary_role: 'QA', skills: {}, home_office: 'Chicago', working_office: 'San Francisco')
    connection = Connection.new(consultant_one, consultant_two)
    allow(connection).to receive(:score).and_return(1.5)

    intersecting_skill = SkillDiff.new('Java', consultant_one, consultant_two)
    intersecting_skills = [intersecting_skill]
    allow(connection).to receive(:intersecting_skills).and_return(intersecting_skills)
    allow(intersecting_skill).to receive(:consultant_one_level)
    allow(intersecting_skill).to receive(:consultant_two_level)

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

  it 'should show offices' do
    expect(rendered).to have_text('San Francisco')
    expect(rendered).to have_text('Chicago')
  end

  it 'should show score' do
    expect(rendered).to have_text('1.5')
  end

  it 'should show intersecting skills' do
    expect(rendered).to have_text('Java')
  end

end
