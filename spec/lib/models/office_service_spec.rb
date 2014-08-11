require 'rails_helper'

describe OfficeService do

  context '.find_by_name' do
    let (:consultant_in_sf) { Consultant.create({full_name: 'derek', home_office: 'San Francisco'}) }
    let (:consultant_in_chicago) { Consultant.create({full_name: 'patrick', home_office: 'Chicago'}) }

    it 'should return an instance of office' do
      expect(OfficeService.find_by_name 'San Francisco').to be_instance_of Office
    end

    it 'should only return consultants in a specific office' do
      office = OfficeService.find_by_name 'San Francisco'
      expect(office.consultants).to include(consultant_in_sf)
      expect(office.consultants).to_not include(consultant_in_chicago)
    end
  end
end
