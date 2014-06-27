require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    mentor_one = Consultant.new(full_name: 'Amber', employee_id: '1')
    mentor_two = Consultant.new(full_name: 'Barbara', employee_id: '2')
    consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])
    mentee_one = Consultant.new(full_name: 'Charlie', employee_id: '4', skills: {})
    mentee_two = Consultant.new(full_name: 'Dee', employee_id: '5', skills: {})

    assign :consultant, consultant

    connection_one = Connection.new(mentor_one, consultant)
    connection_two = Connection.new(mentor_two, consultant)
    mentee_connection_one = Connection.new(consultant, mentee_one)
    mentee_connection_two = Connection.new(consultant, mentee_two)
    assign :mentors, [connection_one, connection_two]
    assign :mentees, [mentee_connection_one, mentee_connection_two]

    assign :activities, [GithubEvent.new(repo_name: 'repo', type: 'PushEvent', languages: {'Ruby'=> '1234'}, created_at: 'create time')]

    allow(connection_one).to receive(:teachable_skills).and_return(['Java'])
    allow(connection_one).to receive(:score).and_return(3.24)
    allow(connection_two).to receive(:teachable_skills).and_return(['Clojure'])
    allow(connection_two).to receive(:score).and_return(1.9900001)
    allow(mentee_connection_one).to receive(:teachable_skills).and_return(['Haskell'])
    allow(mentee_connection_one).to receive(:score).and_return(4.10)
    allow(mentee_connection_two).to receive(:teachable_skills).and_return(['Mandarin'])
    allow(mentee_connection_two).to receive(:score).and_return(0.1333)

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

    it 'should show skills to teach' do
      expect(rendered).to have_text('Cat')
    end

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

  describe 'show mentees' do
    specify {expect(rendered).to have_link('Charlie', :href => '/consultants/4')}
    specify {expect(rendered).to have_link('Dee', :href => '/consultants/5')}

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

  describe 'show activities' do
    it 'should show github events' do
      expect(rendered).to have_text('repo')
      expect(rendered).to have_text('create time')
      expect(rendered).to have_text('Ruby')
      expect(rendered).to have_text('PushEvent')
    end

  end
end
