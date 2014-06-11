require 'rails_helper'

describe ConnectionService do
  context '.all' do
    it 'should return zero connections between zero people' do
      expect(ConnectionService.all.size).to eq 0
    end
    it 'should return two connections between two people' do
      Consultant.create({name: 'Adam'})
      Consultant.create({name: 'Billy'})
      expect(ConnectionService.all.size).to eq 2
    end
    it 'should return six connections between three people' do
      Consultant.create({name: 'Adam'})
      Consultant.create({name: 'Billy'})
      Consultant.create({name: 'Charlotte'})
      expect(ConnectionService.all.size).to eq 6
    end
  end
end
