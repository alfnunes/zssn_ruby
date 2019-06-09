
class ReportService
  class << self
   
    def percentage_infected
      (Survivor.infected_people.count.to_f / Survivor.all.count.to_f) * 100
    end

    def percentage_non_infected
      (Survivor.non_infected_people.count.to_f / Survivor.all.count.to_f) * 100 
    end

    def avg_resource_by_survivor(resource_name)   
      count_resources_by_name(resource_name) / Survivor.all.count.to_f
    end

    def points_lost
      number_of_points(Survivor.infected_people)
    end

  private 

    def count_resources_by_name(resource_name)
      resource_id = Resource.find_by(name: resource_name).id
      InventoryResource.where(resource_id: resource_id).count
    end

    def number_of_points(survivor)     
      survivor.map {|p| p.inventory.resources.map {|r| r.point}.reduce(0, :+)}.reduce(0, :+)
    end

  end
end