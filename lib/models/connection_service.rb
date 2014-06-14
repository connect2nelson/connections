class ConnectionService
  def self.all
    Consultant.all.map do |consultant|
      Consultant.all.not.where('_id' => consultant.id).map do |other|
        Connection.new(consultant, other)
      end
    end.flatten
  end

  def self.sf_office
    for_office('San Francisco').map do |consultant|
      for_office('San Francisco').not.where('_id' => consultant.id).map do |other|
        Connection.new(consultant, other)
      end
    end.flatten
  end

  def self.for_office office
    Consultant.where(working_office: office)
  end
end
