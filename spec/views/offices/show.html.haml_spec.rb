require 'rails_helper'

RSpec.describe "offices/show.html.haml", :type => :view do

  before do
    consultant_in_sf = Consultant.new(full_name: 'Ian Norris', home_office: 'San Francisco')
    office = Office.new [consultant_in_sf]
    assign :office, office

    render
  end

  describe 'show consultants in the office' do
    specify {expect(rendered).to have_text('Ian Norris')}
  end
end
