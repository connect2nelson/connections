require 'active_support/core_ext/hash/indifferent_access'

class EtagResponse
  def initialize raw
    @raw = raw
  end

  def as_hash
    if as_json.is_a?(Array)
      Hash[list: as_array]
    else
      as_json.with_indifferent_access
    end
  end

  def as_array
    if as_json.is_a?(Array)
      as_json.map(&:with_indifferent_access)
    else
      [as_json.with_indifferent_access]
    end
  end

  def as_json
    @json ||= JSON.parse(@raw.body)
  end
end
