require 'rails_helper'

RSpec.describe "offices/show.html.haml", :type => :view do

  before do
    consultant_in_sf = Consultant.new(full_name: 'Ian Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    another_consultant_in_sf = Consultant.new(full_name: 'Derek Hammer', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    office = Office.new [consultant_in_sf, another_consultant_in_sf]
    assign :office, office

    render
  end

  describe 'show consultants in the office' do
    specify {expect(rendered).to have_text('San Francisco')}
    specify {expect(rendered).to have_text('Ian Norris')}
    specify {expect(rendered).to have_text('Derek Hammer')}
    specify {expect(rendered).to have_text('Ruby', count: 1)}
    specify {expect(rendered).to have_text('Java', count: 1)}
    specify {expect(rendered).to have_css('h3:first-of-type', text: 'Ruby')}
  end

  describe 'show filter buttons' do
    specify{expect(rendered).to have_text('Tech')}
    specify{expect(rendered).to have_text('Consulting')}
  end
end
