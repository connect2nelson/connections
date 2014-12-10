require 'rails_helper'

RSpec.describe "offices/show.html.haml", :type => :view do

  before do
    consultant_in_sf = Consultant.new(full_name: 'Ian Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    another_consultant_in_sf = Consultant.new(full_name: 'Derek Hammer', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    office = Office.new [consultant_in_sf, another_consultant_in_sf]
    assign :office, office

    stub_template "offices/_office.html.haml" => ""
    stub_template "offices/_skill_groups.html.haml" => "Example skill"
    stub_template "offices/_sponsorships.html.haml" => ""
    render
  end

  describe 'show skills and Github tabs' do
    specify{expect(rendered).to have_text('Skills')}
    specify{expect(rendered).to have_text('Github Repos')}
    specify{expect(rendered).to have_text('Sponsorship Network')}
    specify{expect(rendered).to have_text('Home')}
  end
end
