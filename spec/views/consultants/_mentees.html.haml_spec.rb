require 'rails_helper'

RSpec.describe "consultants/_mentees.html.haml", :type => :view do

  before do
    consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])
    mentee_one = Consultant.new(full_name: 'Charlie', employee_id: '4', skills: {})
    mentee_two = Consultant.new(full_name: 'Dee', employee_id: '5', skills: {})

    assign :consultant, consultant

    mentee_connection_one = Connection.new(consultant, mentee_one)
    mentee_connection_two = Connection.new(consultant, mentee_two)
    assign :mentees, [mentee_connection_one, mentee_connection_two]

    @create_time = '2014-06-20 -0700'
    @relative_create_time = 'June 20, 2014 12:00am'

    allow(mentee_connection_one).to receive(:teachable_skills).and_return(['Haskell'])
    allow(mentee_connection_one).to receive(:score).and_return(4.10)
    allow(mentee_connection_two).to receive(:teachable_skills).and_return(['Mandarin'])
    allow(mentee_connection_two).to receive(:score).and_return(0.1333)

    render
  end


  describe 'show mentees' do
    specify {expect(rendered).to have_link('Charlie', :href => '/consultants/4')}
    specify {expect(rendered).to have_link('Dee', :href => '/consultants/5')}

    it 'should show skills to teach' do
      expect(rendered).to have_text('Cat')
    end

    it 'should show teachable skills' do
      expect(rendered).to have_text('Haskell')
      expect(rendered).to have_text('Mandarin')
    end

    it 'should show compatibility score' do
      expect(rendered).to have_link('4.10',:href => '/connections/3/and/4')
      expect(rendered).to have_link('0.13',:href => '/connections/3/and/5')
      expect(rendered).to_not have_link('0.1333')
    end
  end

end

