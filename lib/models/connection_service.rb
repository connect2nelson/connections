class ConnectionService
  def self.all
    Consultant.all.map do |consultant|
      Consultant.all.not.where('_id' => consultant.id).map do |other|
        Connection.new(consultant, other)
      end
    end.flatten.sort_by{ |connection|
    	  connection.skill_gap
    	}.reverse
  end

  def self.all_sf_consultants
    for_office('San Francisco').map do |consultant|
        consultant
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

  def self.best_mentors_for mentee
    for_office(mentee.working_office).not.where('_id' => mentee.id).map do |other|
      Connection.new(other, mentee)
    end.flatten.select(&:match?).sort_by(&:skill_gap).reverse
  end

  def self.best_mentees_for mentor
    for_office(mentor.working_office).not.where('_id' => mentor.id).map do |other|
      Connection.new(mentor, other)
    end.flatten.select(&:match?).sort_by(&:skill_gap).reverse
  end
end
