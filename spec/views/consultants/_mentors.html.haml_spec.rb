require 'rails_helper'

RSpec.describe "consultants/_mentors.html.haml", :type => :view do

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
      a_consultant = Consultant.new(full_name: 'Ian Norris', employee_id: '1', skills: Hash['Ruby' => '1'])
      mentor_one = Consultant.new(full_name: 'Charlie', employee_id: '2')
      mentor_two = Consultant.new(full_name: 'Dee', employee_id: '3')
      sponsor = Consultant.new(full_name: 'Pei', employee_id: '4')

      mentor_connection_one = Connection.new(mentor_one, a_consultant)
      mentor_connection_two = Connection.new(mentor_two, a_consultant)
      sponsorship = Connection.new(sponsor, a_consultant)

      allow(mentor_connection_one).to receive(:teachable_skills).and_return(['Java'])
      allow(mentor_connection_one).to receive(:score).and_return(3.24)
      allow(mentor_connection_two).to receive(:teachable_skills).and_return(['Clojure'])
      allow(mentor_connection_two).to receive(:score).and_return(1.9900001)
      allow(sponsorship).to receive(:teachable_skills).and_return(['Ruby'])
      allow(sponsorship).to receive(:score).and_return(4.10)

      render 'mentors', consultant: a_consultant, mentors: [mentor_connection_one, mentor_connection_two], sponsors: [sponsorship]
    end

    describe 'show text box and button to add a sponsor' do
      specify { expect(rendered).to have_css "form[action='/sponsorship'][method='post']" }
      specify { expect(rendered).to have_css "input[value='Add Sponsor']" }
    end

    describe 'show skills' do
      it 'should show skills to learn' do
        expect(rendered).to have_text('Ruby')
      end
    end

    describe 'show mentors and sponsors' do
      specify {expect(rendered).to have_link('Charlie', :href => '/consultants/2')}
      specify {expect(rendered).to have_link('Dee', :href => '/consultants/3')}
      specify {expect(rendered).to have_link('Pei', :href => '/consultants/4')}

      it 'should show teachable skills' do
        expect(rendered).to have_text('Java')
        expect(rendered).to have_text('Clojure')
        expect(rendered).to have_text('Ruby')
      end

      it 'should show compatibility score' do
        expect(rendered).to have_link('3.24',:href => '/connections/2/and/1')
        expect(rendered).to have_link('1.99',:href => '/connections/3/and/1')
        expect(rendered).to have_link('4.10',:href => '/connections/4/and/1')
        expect(rendered).to_not have_link('1.9900001')
      end

    end

  end


end