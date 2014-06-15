require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    mentor_one = Consultant.new(full_name: 'Amber')
    mentor_two = Consultant.new(full_name: 'Barbara')
    consultant = Consultant.new(employee_id: '1111', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: Hash['Ruby'=>'1'])

    assign :consultant, consultant

    connection_one = Connection.new(mentor_one, consultant)
    connection_two = Connection.new(mentor_two, consultant)
    assign :connections, [connection_one, connection_two]

    allow(connection_one).to receive(:teachable_skills).and_return(['Java'])
    allow(connection_two).to receive(:teachable_skills).and_return(['Clojure'])

    render
  end

  describe 'show mentee' do
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

  describe 'show mentors' do
    specify {expect(rendered).to have_text('Amber')}
    specify {expect(rendered).to have_text('Barbara')}

    it 'should show teachable skills' do
      expect(rendered).to have_text('Java')
      expect(rendered).to have_text('Clojure')
    end

  end

end
