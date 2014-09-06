require 'rails_helper'

RSpec.describe "consultants/index.html.haml", :type => :view do

before do
	render
end

it 'should show about page link' do
    expect(rendered).to have_link('What is this?', href: '/about')
end

end
