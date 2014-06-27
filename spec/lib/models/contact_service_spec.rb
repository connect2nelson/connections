require 'rails_helper'

describe ContactService do

  context '.all_with_github' do

    it 'should return github accounts for employees' do
      Contact.create({employee_id: '111', github_account: 'yo'})
      Contact.create({employee_id: '222', github_account: ''})
      Contact.create({employee_id: '333'})
      expect(ContactService.all_with_github.size).to eq 1
      expect(ContactService.all_with_github.first[:employee_id]).to eq '111'
    end
  end

end
