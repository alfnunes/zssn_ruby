require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  let(:create_survivors) do
    create :survivor
    create :survivor
    create :survivor, :infected
    create :survivor, :infected
    create :survivor, :infected
  end 

  let(:create_survivors_with_resources) do  
    person_infected = create(:survivor, :infected, :create_inventory)
    am = create(:resource_ammunition)  
    person_infected.inventory.inventory_resources.create(resource: am)

    person_infected = create(:survivor, :infected, :create_inventory)
    med = create(:resource_medication)  
    person_infected.inventory.inventory_resources.create(resource: med)

    person_infected = create(:survivor, :infected, :create_inventory)
    food = create(:resource_food)  
    person_infected.inventory.inventory_resources.create(resource: food)

    person_infected = create(:survivor, :infected, :create_inventory)
    water = create(:resource_water)  
    person_infected.inventory.inventory_resources.create(resource: water)
  end

  describe 'percentage_infected' do
    it 'Percentage of infected survivors' do
      create_survivors
      get :percentage_infected
      expect(json_response['percentage']).to eq(60.0)
    end
  end

  describe 'percentage_non_infected' do
    it 'Percentage of non-infected survivors' do
      create_survivors
      get :percentage_non_infected
      expect(json_response['percentage']).to eq(40.0)
    end
  end

  describe 'avg_resource_by_survivor' do
    it 'Average amount of each kind of resource by survivor' do
      create_survivors_with_resources
      get :avg_resource_by_survivor
      expect(json_response['avg_ammunition']).to eq(0.25)
      expect(json_response['avg_medication']).to eq(0.25)
      expect(json_response['avg_food']).to eq(0.25)
      expect(json_response['avg_water']).to eq(0.25)
    end
  end

  describe 'points_lost' do
    it 'Points lost because of infected survivor' do
      create_survivors_with_resources
      get :points_lost
      expect(json_response['number']).to eq(10)
    end
  end
end