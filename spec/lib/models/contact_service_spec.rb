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

  context '.github_name_for' do

    before do
      Contact.create({employee_id: '111', github_account: 'yo'})
    end

    it 'should return empty string for an employee without github info' do
      consultant = Consultant.new(employee_id: '000')
      expect(ContactService.github_name_for consultant).to eq ""
    end

    it 'should return github account name for an employee with github info' do
      consultant = Consultant.new(employee_id: '111')
      expect(ContactService.github_name_for consultant).to eq 'yo'
    end
  end

end
