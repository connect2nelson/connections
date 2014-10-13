class SponsorshipService

  def self.get_sponsees_for sponsor
    sponsees = []
    sponsorships = Sponsorship.all(sponsor_id: sponsor.employee_id)
    sponsorships.each do |sponsorship|
      sponsees.push(
          Connection.new(sponsor, Consultant.find_by(employee_id: sponsorship.sponsee_id))
      )
    end
    sponsees
  end
end
