require 'spec_helper'

describe EtagRequest do

  let(:url) {'some_url'}
  let(:etag) {'some_etag'}

  before do
    @etag_request = EtagRequest.new(url, etag)
  end

  it 'should creates response' do
    expect(HTTParty).to receive(:get).once
    @etag_request.response
  end

end
