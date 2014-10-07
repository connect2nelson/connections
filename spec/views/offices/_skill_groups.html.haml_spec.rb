require 'rails_helper'

RSpec.describe "offices/_skill_groups.html.haml", :type => :view do

  before do
    consultant_in_sf = Consultant.new(full_name: 'Ian Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    another_consultant_in_sf = Consultant.new(full_name: 'Derek Hammer', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    skill_groups = {"Ruby"=>[consultant_in_sf, another_consultant_in_sf], "Java"=>[consultant_in_sf, another_consultant_in_sf]}

    render 'skill_groups', skill_group: skill_groups
  end

  describe 'show consultants in the office' do
    specify {expect(rendered).to have_text('Ian Norris')}
    specify {expect(rendered).to have_text('Derek Hammer')}
    specify {expect(rendered).to have_text('Ruby', count: 1)}
    specify {expect(rendered).to have_text('Java', count: 1)}
    specify {expect(rendered).to have_css('h3:first-of-type', text: 'Ruby')}
  end

end
