class ContactService

  def self.all_with_github
    Contact.where(:github_account.nin => ["", nil])
  end


end
