require 'rails_helper'

describe EtagRequest do

  let(:url) {'some_url'}
  let(:etag) {'some_etag'}
  let(:rest_client) { double(:get) }

  before do
    allow(RestClient::Resource).to receive(:new)
      .with(/url/).and_return(rest_client)
    @etag_request = EtagRequest.new(url, etag)
  end

  it 'should creates response' do
    expect(rest_client).to receive(:get).once
      .with({:if_none_match => etag})
    @etag_request.response
  end

end
