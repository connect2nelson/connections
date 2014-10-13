require 'rails_helper'

RSpec.describe "consultants/_sponsorship.html.haml", :type => :view do

  before do
    stub_template "consultants/_mentees.html.haml" => ""
    render
  end

  describe 'show text box and button to add a sponsee' do
    # specify{expect(rendered).to have_text('Add Sponsee')}
  end
end
