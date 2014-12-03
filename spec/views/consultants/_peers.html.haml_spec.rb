require 'rails_helper'

RSpec.describe "consultants/_peers.html.haml", :type => :view do

  before do
    a_consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', skills: {'Cat' => '5'})
    peer_one = Consultant.new(full_name: 'Charlie', employee_id: '4', skills: {})
    peer_two = Consultant.new(full_name: 'Dee', employee_id: '5', skills: {})

    peer_connection_one = Connection.new(a_consultant, peer_one)
    peer_connection_two = Connection.new(a_consultant, peer_two)
    some_peers = [peer_connection_one, peer_connection_two]

    allow(peer_connection_one).to receive(:teachable_skills).and_return(['Haskell'])
    allow(peer_connection_one).to receive(:score).and_return(4.10)
    allow(peer_connection_two).to receive(:teachable_skills).and_return(['Mandarin'])
    allow(peer_connection_two).to receive(:score).and_return(0.1333)

    render 'consultants/peers', consultant: a_consultant, peers: some_peers
  end

  describe 'show peers' do
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

