class ContactService

  def self.all_with_github
    Contact.where(:github_account.nin => ["", nil])
  end

  def self.github_name_for consultant
    contact = Contact.find_by(employee_id: consultant.employee_id)
    return "" if contact.nil?
    contact.github_account
  end


end
