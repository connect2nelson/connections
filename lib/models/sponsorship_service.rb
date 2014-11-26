require 'json'

class SponsorshipService
  def self.get_sponsors_for sponsee
    sponsors = []
    sponsorships = Sponsorship.all(sponsee_id: sponsee.employee_id)
    sponsorships.each do |sponsorship|
      sponsors.push(
          Connection.new(Consultant.find_by(employee_id: sponsorship.sponsor_id), sponsee)
      )
    end
    sponsors
  end

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

  JC_GRADE = "Con - Grad"

  def self.get_sponsorless_ACs_for office
    acs = Consultant.where(:grade => JC_GRADE).where(:home_office => office)
    return get_sponsorless_for(acs)
  end

  def self.get_sponsorless_individuals_for office
    office_consultants = Consultant.not.where(:grade => JC_GRADE).where(:home_office => office).to_a
    return get_sponsorless_for(office_consultants)
  end

  def self.get_sponsorless_for(consultants)
    consultant_ids = consultants.map(&:employee_id)
    consultant_ids_with_sponsors = Sponsorship.where(:sponsee_id.in => consultant_ids).map(&:sponsee_id)
    consultant_ids_without_sponsors = consultant_ids - consultant_ids_with_sponsors
    return Consultant.where(:employee_id.in => consultant_ids_without_sponsors)
  end

  def self.get_connection_for sponsorship
    Connection.new(Consultant.find_by(employee_id: sponsorship.sponsor_id), Consultant.find_by(employee_id: sponsorship.sponsee_id))
  end

  def self.get_network_for consultants
    network = {:nodes => [], :links => []}
    nodes = network[:nodes]

    consultants.each do |consultant|
      node = create_node_from(consultant)
      nodes.push(node)
    end

    consultants.each do |consultant|
      consultant_index = index_of_node_with(nodes, consultant.employee_id)

      sponsees = Sponsorship.all({sponsor_id: consultant["employee_id"]})
      sponsees.each do |sponsorship|
        sponsee_index = index_of_node_with(nodes, sponsorship.sponsee_id)

        if(sponsee_index.nil?)
          node_for_out_of_office_consultant(nodes, sponsorship.sponsee_id)
          sponsee_index = nodes.length - 1
        end

        link = {
            "source" => consultant_index,
            "target" => sponsee_index
        }
        network[:links].push(link)
      end

      sponsors = Sponsorship.all({sponsee_id: consultant["employee_id"]})
      sponsors.each do |sponsorship|
        sponsor_index = index_of_node_with(nodes, sponsorship.sponsor_id)

        #If your sponsor was in the office in the first place, a link between you two will be added
        # when we hit the iteration where they are the consultant in question
        if(sponsor_index.nil?)
          node_for_out_of_office_consultant(nodes, sponsorship.sponsor_id)
          sponsor_index = nodes.length - 1

        link = {
            "source" => sponsor_index,
            "target" => consultant_index
        }
        network[:links].push(link)
        end
      end
    end

    network
  end

  def self.index_of_node_with(nodes, employee_id)
    nodes.index { |item| item["employee_id"] == employee_id }
  end

  def self.create_node_from(consultant)
    {
        "employee_id" => consultant.employee_id,
        "full_name" => consultant.full_name,
        "office" => consultant.home_office
    }
  end

  def self.node_for_out_of_office_consultant(nodes, consultant_id)
    sponsor = Consultant.find_by(employee_id: consultant_id)
    node = create_node_from(sponsor)
    nodes.push(node)
  end


end
