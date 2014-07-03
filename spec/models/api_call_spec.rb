require 'rails_helper'

RSpec.describe ApiCall, :type => :model do

  describe 'attributes' do
    it 'should have attributes' do
      expect(subject).to have_fields(:url, :etag)
    end

    it 'should have indexes' do
      expect(subject.index_specifications.size).to eq 1
      expect(subject.index_specifications.first.key[:url]).to eq 1
      expect(subject.index_specifications.first.options[:unique]).to be true
    end
  end

end


