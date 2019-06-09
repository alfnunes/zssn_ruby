require 'rails_helper'

RSpec.describe SurvivorsController, type: :controller do
  
  describe 'create' do
    context 'with valid attributes' do
      before :each do
        resouce = create(:resource_ammunition)
        post :create, params:
                            { name: Faker::Name.unique.name, 
                              age: Faker::Number.between(15, 90), 
                              gender: Faker::Gender.binary_type, 
                              latitude: Faker::Address.latitude,
                              longitude: Faker::Address.longitude,
                              last_location: ActiveRecord::Point.new(Faker::Address.latitude , Faker::Address.longitude),
                              resources: [
                                {                             
                                  resource_id: resouce.id,
                                  amount: 1                                
                                }
                              ]
                            }

      end

      let(:survivor) { Survivor.first }
      let(:survivor_inventory) { survivor.inventory }
      let(:survivor_resources) { survivor.inventory.resources }
      let(:survivor_inventory_resources) { survivor.inventory.inventory_resources }
 
      it '201 status' do
        expect(response.status).to eq 201
      end
      it 'count' do
        expect(Survivor.count).to eq 1
      end       
    end
  end

  describe 'index' do
    it 'Http Status OK 200' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns the index survivor to @survivor" do
      survivors = create_list(:survivor, 3)
      get :index
      expect(assigns(:survivors)).to match_array(survivors)
    end
  end 
  
  describe 'report_infection' do
    it "return successful to report infection with the message with count times and api returns status 200 (ok)" do
      survivor = create(:survivor, reported_infected_count: 1)
      get :report_infection, params: { id: survivor.id }
      expect(json_response['message']).to eq "Survivor reported as infected with #{survivor.reported_infected_count + 1} times"
    end
    it "return successful to report infection with the message that Survivor was infected and api returns status 200 (ok)" do
      person = create(:survivor, :infected)
      get :report_infection, params: { id: person.id }
      expect(json_response['message']).to eq 'Survivor is infected'
    end
  end
end