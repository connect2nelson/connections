class ConnectionService
  def self.all
    Consultant.all.map do |consultant|
      Consultant.all.not.where('_id' => consultant.id).map do |other|
        Connection.new(consultant, other)
      end
    end.flatten
  end
end
