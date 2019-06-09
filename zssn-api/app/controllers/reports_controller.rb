class ReportsController < ApplicationController
 
  def percentage_infected
    render json: {
      description: "Percentage of infected survivors",
      percentage: ReportService.percentage_infected
    }
  end

  def percentage_non_infected
    render json: {
      description: "Percentage of non-infected survivors",
      percentage: ReportService.percentage_non_infected
    }
  end

  def avg_resource_by_survivor
    render json: {
      description: "Average amount of each kind of resource by survivor",
      avg_ammunition: ReportService.avg_resource_by_survivor(ConstantHelper::Ammunition),
      avg_medication: ReportService.avg_resource_by_survivor(ConstantHelper::Medication),
      avg_food: ReportService.avg_resource_by_survivor(ConstantHelper::Food),
      avg_water: ReportService.avg_resource_by_survivor(ConstantHelper::Water)
    }
  end

  def points_lost
    render json: {
      description: "Points lost because of infected survivor",
      number: ReportService.points_lost
    }
  end
end