require 'rails_helper'

RSpec.describe "offices/_skill_groups.html.haml", :type => :view do

  before do
    @consultant_in_sf = Consultant.new(employee_id: 1, full_name: 'Ian Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    @another_consultant_in_sf = Consultant.new(employee_id: 2, full_name: 'Derek Hammer', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    third_consultant = Consultant.new(full_name: 'Peiying Wen', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    fourth_consultant = Consultant.new(full_name: 'Jeff Norris', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    fifth_consultant = Consultant.new(full_name: 'Pam Ocampo', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    sixth_consultant = Consultant.new(full_name: 'Linda Goldstein', home_office: 'San Francisco', skills: {'Java' => '5', 'Ruby' => '5'})
    many_consultants = [@consultant_in_sf, @another_consultant_in_sf, third_consultant, fourth_consultant, fifth_consultant, sixth_consultant]
    grezhaRepo = GithubContributersViewModel.new([@consultant_in_sf,@another_consultant_in_sf], "grezha")
    swiftRepo = GithubContributersViewModel.new(many_consultants, "swift")
    connectionsRepo = GithubContributersViewModel.new([@consultant_in_sf], "connections")

    github_contributer_viewmodels = [connectionsRepo, swiftRepo, grezhaRepo]
    render 'github_groups', repo_groups: github_contributer_viewmodels
  end

  describe 'show github accounts with links and urls' do
  	specify {expect(rendered).to have_link("grezha", "https://github.com/grezha")}
  	specify {expect(rendered).to have_link("swift", "https://github.com/swift")}
  	specify {expect(rendered).to have_link("connections", "https://github.com/connections")}
  end

  describe 'should link to consultants shown with each account' do


  	specify {expect(rendered).to have_link("Ian Norris", "/consultants/1")}
  	specify {expect(rendered).to have_link("Derek Hammer", "/consultants/2")}
  end

  describe "show max 5 consultants per github account" do 
  	specify {expect(rendered).to have_text("Ian Norris")}
  	specify {expect(rendered).to have_text("Derek Hammer")}
  	specify {expect(rendered).to have_text("Peiying Wen")}
  	specify {expect(rendered).to have_text("Jeff Norris")}
  	specify {expect(rendered).to have_text("Pam Ocampo")}
  	specify {expect(rendered).to_not have_text("Linda Goldstein")}
  	specify {expect(rendered).to have_text("swift")}
  	specify {expect(rendered).to have_text("grezha")}
  	specify {expect(rendered).to have_text("connections")}
  end


end
