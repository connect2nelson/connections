class OfficeService
  def self.find_by_name name
    consultants = Consultant.where(home_office: name)
    Office.new consultants.to_a
  end

  def self.find_all_offices
    Consultant.distinct(:working_office)
  end
end
