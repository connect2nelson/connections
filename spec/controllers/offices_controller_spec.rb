require 'rails_helper'

RSpec.describe OfficesController, :type => :controller do

  describe "GET 'show'" do

    let(:office) {Office.new([])}

    it 'should show office' do
      expect(OfficeService).to receive(:find_by_name).with('San Francisco')
      get :show, name: 'san-francisco'
    end

    it 'should assign office' do
      allow(OfficeService).to receive(:find_by_name).with('Chicago').and_return(office)
      get :show, name: 'chicago'
      expect(assigns(:office)).to eq office
    end

  end

  describe "GET 'network'" do

    let(:office) {Office.new([])}

    it 'should assign office' do
      allow(OfficeService).to receive(:find_by_name).with('Chicago').and_return(office)
      get :network, name: 'chicago', format: :json

      expect(assigns(:office)).to eq office
    end

    it 'should get sponsorship network' do
      allow(OfficeService).to receive(:find_by_name).with('Chicago').and_return(office)
      allow(office).to receive(:sponsorship_network).and_return("some json")
      get :network, name: 'chicago', format: :json

      expect(response).to be_success
      expect(response.body).to eq("some json".to_json)
    end

  end

end
