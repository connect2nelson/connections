require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    mentor_one = Consultant.new(full_name: 'Amber', employee_id: '1')
    mentor_two = Consultant.new(full_name: 'Barbara', employee_id: '2')
    consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])

    assign :consultant, consultant
    @create_time = '2014-06-20 -0700'
    @relative_create_time = 'June 20, 2014 12:00am'

    stub_template "consultants/_mentees.html.haml" => ""
    stub_template "consultants/_mentors.html.haml" => ""
    stub_template "consultants/_sponsorship.html.haml" => ""
    render
  end

  describe 'show consultant' do
    specify {expect(rendered).to have_text('Ian Norris')}
    specify {expect(rendered).to have_text('Dev')}

    it 'should show offices' do
      expect(rendered).to have_text('San Francisco')
      expect(rendered).to have_text('Chicago')
    end
  end

  describe 'show Mentor, Mentees, and Sponsorship tabs' do
    specify{expect(rendered).to have_text('Mentor')}
    specify{expect(rendered).to have_text('Mentees')}
    specify{expect(rendered).to have_text('Sponsorship')}
  end
end
