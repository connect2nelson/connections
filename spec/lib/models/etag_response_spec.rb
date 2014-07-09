require 'spec_helper'
require 'json'

describe EtagResponse do
  context 'array response' do
    let(:array) { [{a: 2}.stringify_keys] }
    let(:response) { double(body: array.to_json) }
    subject { EtagResponse.new(response) }
    it 'should give back array' do
      expect(subject.as_array).to eq array
    end
    it 'should give back hash' do
      expect(subject.as_hash).to eq Hash[list: array]
    end
  end

  context 'hash response' do
    let(:hash) { {a: 2} }
    let(:response) { double(body: hash.to_json) }
    subject { EtagResponse.new(response) }
    it 'should give back array' do
      expect(subject.as_array).to eq [hash.stringify_keys]
    end
    it 'should give back hash' do
      expect(subject.as_hash).to eq hash.stringify_keys
    end
  end

end

