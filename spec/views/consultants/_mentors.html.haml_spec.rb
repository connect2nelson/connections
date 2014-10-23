require 'rails_helper'

RSpec.describe "consultants/_mentees.html.haml", :type => :view do

  before do
    consultant = Consultant.new(employee_id: '3', full_name: 'Ian Norris', primary_role: 'Dev', home_office: 'Chicago', working_office: 'San Francisco', skills: {})
    allow(consultant).to receive(:has_skills_from_jigsaw?).and_return(false)
    render 'mentors', consultant: consultant, mentors: []
  end


  describe "shows image when no skills" do 
    specify {expect(rendered).to have_css("img[src='/assets/jigsaw-300.jpg']")}
  end
end