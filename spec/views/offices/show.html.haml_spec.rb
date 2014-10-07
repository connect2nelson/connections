require 'rails_helper'

RSpec.describe "offices/show.html.haml", :type => :view do

  before do
    consultant_in_sf = Consultant.new(full_name: 'Ian Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    another_consultant_in_sf = Consultant.new(full_name: 'Derek Hammer', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    office = Office.new [consultant_in_sf, another_consultant_in_sf]
    assign :office, office

    stub_template "offices/_office.html.haml" => ""
    stub_template "offices/_skill_groups.html.haml" => "Example skill"
    render
  end

  describe 'show filter buttons' do
    specify{expect(rendered).to have_text('All')}
    specify{expect(rendered).to have_text('Tech')}
    specify{expect(rendered).to have_text('Consulting')}
  end
end
