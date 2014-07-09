require 'spec_helper'

describe EtagNullResponse do
  specify { expect(subject.as_hash).to eq Hash.new }
  specify { expect(subject.as_array).to eq Array.new }
end
