class SurvivorsController < ApplicationController
  before_action :find_survivor, only: [:show, :update, :destroy, :report_infection]

  def index
    Rails.logger.info(':::: Index Method calling ::::') if Rails.env = "Development"  
    @survivors = Survivor.all
    render json: @survivors
  end

  def create  
    @survivor = Survivor.new(survivor_params)   
    if @survivor.save
      render json: @survivor, status: :created
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def update  
    if @survivor.update_attributes(update_params)
      head :no_content, status: :ok
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def report_infection
    unless @survivor.infected 
      @survivor.increment_infection     
      @survivor.save
      render json: { message: "Survivor reported as infected with #{@survivor.reported_infected_count} times"  }, status: :ok
    else
      render json: { message: "Survivor is infected" }, status: :ok
    end
  end

  def show         
    Rails.logger.info(':::: Show Method calling ::::') if Rails.env = "Development"
    resources = get_resource_of_survivor(@survivor.inventory.inventory_resources)
    render json: @survivor.as_json.merge(resources: resources.as_json) 
  end
 
  private
    def find_survivor
      Rails.logger.info(":::: get_survivor_by_id Method calling with param #{params[:id]} :::: ") if Rails.env = "Development" 
      begin
        @survivor = Survivor.find(params[:id])   
      rescue ActiveRecord::RecordNotFound
        return render json: { message: "Survivor doesn't exist" }, status: :not_found
      end     
    end

    def survivor_params
      params
        .permit(:name, :age, :gender)
        .merge( last_location: parse_position,
                infected: false, 
                inventory_attributes: {
                  inventory_resources_attributes: parse_resources
                }
              )
    end 

    def parse_position
      ActiveRecord::Point.new(params[:latitude], params[:longitude]) 
    end

    def parse_resources
      resources = []
      
      params[:resources].each do |resource|       
        resource[:amount].to_i.times do |i|
          resources << { resource_id: resource[:resource_id] }
        end      
      end

      resources
    end

    def update_params
      params.permit(:latitude, :longitude).merge(last_location: parse_position).except(:latitude, :longitude)
    end

    def get_resource_of_survivor(inventories)
      hash_resource = inventories.map {|s| s.resource_id}.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
      resources = []
      inventories.map {|s| s.resource_id}.uniq.each do |i|
        resources << {resource_id: i, amount: hash_resource[i] }
      end
      resources
    end
end