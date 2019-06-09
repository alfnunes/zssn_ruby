class Survivor < ApplicationRecord
  has_one :inventory
  has_many :inventory_resources, through: :inventory

  accepts_nested_attributes_for :inventory

  validates :name, :age, :gender, :last_location, presence: true
  validates :name, uniqueness: true

  scope :infected_people, -> { where("infected = ?", true) }
  scope :non_infected_people, -> { where("infected = ?", false) }

  def increment_infection  
    self.increment(:reported_infected_count, 1) if self.reported_infected_count <= 3    
    set_infected if self.reported_infected_count >= 3   
  end

  def make_trade(another_survivor, resources)
    resources.each do |res|
      (1..res[:amount].to_i).each do |times|
        resource = Resource.find(res[:resource_id].to_i)   
        another_survivor.inventory.inventory_resources.create(resource: resource)
        InventoryResource.where(resource: resource, inventory: self.inventory).first.destroy   
      end
    end       
  end

  def build_geolocalization(lat, long)
    ActiveRecord::Point.new(lat, long)
  end 

  private
 
  def set_infected   
    self.infected = true
  end 
end