require 'rails_helper'

describe ApiCallService do

  context '.etag_from' do

    it 'should return nil if url not found' do
      expect(ApiCallService.etag_from 'random_url').to be_nil
    end

    it 'should return etag if url found' do
      ApiCall.create({url: 'random_url', etag: 'some_etag'})
      expect(ApiCallService.etag_from 'random_url').to eq 'some_etag'
    end
  end

  context '.save' do

    context 'new record' do
      it 'should save' do
        ApiCallService.save 'random_url', 'some_etag'
        expect(ApiCall.all.size).to eq 1
        expect(ApiCall.first[:url]).to eq 'random_url'
        expect(ApiCall.first[:etag]).to eq 'some_etag'
      end
    end

    context 'old record' do
      it 'should update etag' do
        ApiCall.create({url: 'random_url', etag: 'existing_etag'})
        ApiCallService.save 'random_url', 'new_etag'
        expect(ApiCall.first[:etag]).to eq 'new_etag'
      end
    end

  end
end
