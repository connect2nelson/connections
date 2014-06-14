require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    assign :consultant, Consultant.new(employee_id: '1111', full_name: 'Ian Norris', working_office: 'San Francisco')
    render
  end

  specify {expect(rendered).to have_text('Ian Norris')}
  specify {expect(rendered).to have_text('San Francisco')}
end
