require 'rails_helper'

RSpec.describe ConsultantsController, :type => :controller do

  describe 'show GET' do

    let(:consultant) {Consultant.new(employee_id: "1")}

    it 'should show user' do
      expect(Consultant).to receive(:find).with({:employee_id=>consultant.employee_id})
      get :show, Hash[id: consultant.employee_id]
    end

  end

end
