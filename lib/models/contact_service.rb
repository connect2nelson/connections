class ContactService

  def self.all_with_github
    Contact.where(:github_account.nin => ["", nil])
  end

  def self.contacts_for consultant
    Contact.find_by(employee_id: consultant.employee_id)
  end


end
