require 'rails_helper'

describe ConnectionService do
  context '.all' do
    it 'should return zero connections between zero people' do
      expect(ConnectionService.all.size).to eq 0
    end
    it 'should return two connections between two people' do
      Consultant.create({full_name: 'Adam'})
      Consultant.create({full_name: 'Billy'})
      expect(ConnectionService.all.size).to eq 2
    end
    it 'should return six connections between three people' do
      Consultant.create({full_name: 'Adam'})
      Consultant.create({full_name: 'Billy'})
      Consultant.create({full_name: 'Charlotte'})
      expect(ConnectionService.all.size).to eq 6
    end


  end

end
