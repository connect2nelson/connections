require 'rails_helper'

RSpec.describe "consultants/_sponsorship.html.haml", :type => :view do

  before do
  	 a_consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])
    mentee_one = Consultant.new(full_name: 'Charlie', employee_id: '4', skills: {})
    mentee_two = Consultant.new(full_name: 'Dee', employee_id: '5', skills: {})

    mentee_connection_one = Connection.new(a_consultant, mentee_one)
    mentee_connection_two = Connection.new(a_consultant, mentee_two)
    some_mentees = [mentee_connection_one, mentee_connection_two]

    allow(mentee_connection_one).to receive(:teachable_skills).and_return(['Haskell'])
    allow(mentee_connection_one).to receive(:score).and_return(4.10)
    allow(mentee_connection_two).to receive(:teachable_skills).and_return(['Mandarin'])
    allow(mentee_connection_two).to receive(:score).and_return(0.1333)
    render "sponsorship", sponsees: some_mentees, consultant: a_consultant
  end

  describe 'show text box and button to add a sponsee' do
  	specify{expect(rendered).to have_css "form[action='/sponsorship'][method='post']"}
  	specify{expect(rendered).to have_css "input[value='Add Sponsee']"}
  end
end
