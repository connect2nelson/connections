require 'rails_helper'

RSpec.describe ConnectionsController, :type => :controller do

  describe "GET 'show'" do
    let(:consultant_one) {Consultant.new(employee_id: "1")}
    let(:consultant_two) {Consultant.new(employee_id: "2")}

    it "returns http success" do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant_one.employee_id}).and_return consultant_one
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant_two.employee_id}).and_return consultant_two
      get 'show', first_employee_id: '1', second_employee_id: '2'
    end
  end

end
