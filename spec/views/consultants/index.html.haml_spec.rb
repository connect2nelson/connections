require 'rails_helper'

RSpec.describe "consultants/index.html.haml", :type => :view do

before do
  assign :offices, ["Dallas", "Atlanta"]
  render
end

it 'should show about page link' do
    expect(rendered).to have_link('What is this?', href: '/about')
end

it 'should show all of the offices' do
    expect(rendered).to have_link('Dallas', href: 'offices/Dallas')
    expect(rendered).to have_link('Atlanta', href: 'offices/Atlanta')
end

end
