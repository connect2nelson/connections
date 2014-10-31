require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    mentor_one = Consultant.new(full_name: 'Amber', employee_id: '1')
    mentor_two = Consultant.new(full_name: 'Barbara', employee_id: '2')
    consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])

    assign :consultant, consultant

    connection_one = Connection.new(mentor_one, consultant)
    connection_two = Connection.new(mentor_two, consultant)
    assign :mentors, [connection_one, connection_two]

    @create_time = '2014-06-20 -0700'
    @relative_create_time = 'June 20, 2014 12:00am'

    allow(connection_one).to receive(:teachable_skills).and_return(['Java'])
    allow(connection_one).to receive(:score).and_return(3.24)
    allow(connection_two).to receive(:teachable_skills).and_return(['Clojure'])
    allow(connection_two).to receive(:score).and_return(1.9900001)

    stub_template "consultants/_mentees.html.haml" => ""
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

    it 'should show skills to learn' do
      expect(rendered).to have_text('Ruby')
    end

  end

  describe 'show Mentor, Mentees, and Sponsorship tabs' do
    specify{expect(rendered).to have_text('Mentor')}
    specify{expect(rendered).to have_text('Mentees')}
    specify{expect(rendered).to have_text('Sponsorship')}
  end

  describe 'show mentors' do
    specify {expect(rendered).to have_link('Amber', :href => '/consultants/1')}
    specify {expect(rendered).to have_link('Barbara', :href => '/consultants/2')}

    it 'should show teachable skills' do
      expect(rendered).to have_text('Java')
      expect(rendered).to have_text('Clojure')
    end

    it 'should show compatibility score' do
      expect(rendered).to have_link('3.24',:href => '/connections/1/and/3')
      expect(rendered).to have_link('1.99',:href => '/connections/2/and/3')
      expect(rendered).to_not have_link('1.9900001')
    end

  end

end
