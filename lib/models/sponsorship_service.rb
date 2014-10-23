require 'json'

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

    nodes.each do |node|
      sponsorships = Sponsorship.or({sponsor_id: node["employee_id"]}, {sponsee_id: node["employee_id"]})

      sponsorships.each do |sponsorship|
        sponsor_index = index_of_node_with(nodes, sponsorship.sponsor_id)
        sponsee_index = index_of_node_with(nodes, sponsorship.sponsee_id)

        if(sponsor_index.nil?)
          node_for_out_of_office_consultant(nodes, sponsorship.sponsor_id)
          sponsor_index = nodes.length - 1
        end

        if(sponsee_index.nil?)
          node_for_out_of_office_consultant(nodes, sponsorship.sponsee_id)
          sponsee_index = nodes.length - 1
        end

        link = {
            "source" => sponsor_index,
            "target" => sponsee_index
        }
        network[:links].push(link)
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
        "office" => consultant.working_office
    }
  end

  def self.node_for_out_of_office_consultant(nodes, consultant_id)
    sponsor = Consultant.find_by(employee_id: consultant_id)
    node = create_node_from(sponsor)
    nodes.push(node)
  end

end
