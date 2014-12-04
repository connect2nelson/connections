require 'spec_helper'
require './app/services/api_call_service'

describe EtagRequestService do

  let(:url) {'some_url'}
  let(:etag) {'some_etag'}
  let(:mocked_request) { double(:response) }
  let(:mocked_response) {
    double(headers: {etag: ''}, body: "[{\"event_id\": \"1\"}]")
  }

  before do
    allow(ApiCallService).to receive(:etag_from)
      .with(url).and_return(etag)
    allow(EtagRequest).to receive(:new)
      .with(url, etag).and_return(mocked_request)
  end

  context 'returns 200 OK' do
    before do
      allow(mocked_request).to receive(:response)
        .and_return(mocked_response)
    end

    it 'should save etag to url' do
      expect(ApiCallService).to receive(:save)
        .with(url, mocked_response.headers[:etag])
      EtagRequestService.create url
    end

    it 'should return response' do
      allow(ApiCallService).to receive(:save)
      expect(EtagRequestService.create(url).as_array.first["event_id"]).to eq "1"
    end
  end

  context 'returns exception code' do
    it 'should return null etag response' do
      allow(mocked_request).to receive(:response)
        .and_raise(HTTParty::Error)
      expect(EtagRequestService.create url).to be_kind_of EtagNullResponse
    end
  end

end
