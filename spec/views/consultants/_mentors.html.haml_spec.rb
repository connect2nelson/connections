require 'rails_helper'

RSpec.describe "consultants/_mentees.html.haml", :type => :view do

  context 'no skills' do
    before do
      no_skills = Consultant.new(employee_id: '3', full_name: 'Fake Person', skills: {})
      allow(no_skills).to receive(:has_skills_from_jigsaw?).and_return(false)

      render 'mentors', consultant: no_skills, mentors: []
    end


    describe "shows image when no skills" do
      specify { expect(rendered).to have_css("img[src='/assets/jigsaw-300.jpg']") }
    end
  end

  context 'has skills' do

    before do
      a_consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby' => '1'])
      mentor_one = Consultant.new(full_name: 'Charlie', employee_id: '4', skills: Hash['Ruby' => '5'])
      mentor_two = Consultant.new(full_name: 'Dee', employee_id: '5', skills: Hash['Ruby' => '5'])

      mentor_connection_one = Connection.new(a_consultant, mentor_one)
      mentor_connection_two = Connection.new(a_consultant, mentor_two)

      render 'mentors', consultant: a_consultant, mentors: [mentor_connection_one, mentor_connection_two]
    end

    describe 'show text box and button to add a sponsee' do
      specify { expect(rendered).to have_css "form[action='/sponsorship'][method='post']" }
      specify { expect(rendered).to have_css "input[value='Add Sponsee']" }
    end
  end


end