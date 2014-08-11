require 'rails_helper'

RSpec.describe OfficesController, :type => :controller do

  describe "GET 'show'" do

    let(:office) {Office.new([])}

    it 'should show office' do
      expect(OfficeService).to receive(:find_by_name).with('San Francisco')
      get :show, Hash[name: 'san-francisco']
    end

    it 'should assign office' do
      allow(OfficeService).to receive(:find_by_name).with('Chicago').and_return(office)
      get :show, Hash[name: 'chicago']
      expect(assigns(:office)).to eq office
    end

  end

end
