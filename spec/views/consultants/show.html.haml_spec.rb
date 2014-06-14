require 'rails_helper'

describe 'consultants/show.html.haml' do

  before do
    mentor1 = Consultant.new(full_name: 'Amber')
    mentor2 = Consultant.new(full_name: 'Barbara')
    consultant = Consultant.new(employee_id: '1111', full_name: 'Ian Norris', working_office: 'San Francisco', skills: Hash['Ruby'=>'1'])
    assign :consultant, consultant
    assign :connections, [Connection.new(mentor1, consultant), Connection.new(mentor2, consultant)]
    render
  end

  specify {expect(rendered).to have_text('Ian Norris')}
  specify {expect(rendered).to have_text('San Francisco')}
  specify {expect(rendered).to have_text('Ruby')}
  specify {expect(rendered).to have_text('Amber')}
  specify {expect(rendered).to have_text('Barbara')}

end
