FactoryGirl.define do
  factory :survivor do
    name { Faker::Name.unique.name }
    age {Faker::Number.between(15, 90)}
    gender { Faker::Gender.binary_type }
    last_location { ActiveRecord::Point.new(Faker::Address.latitude , Faker::Address.longitude)}
    infected false
    reported_infected_count 0

    trait :infected do
      infected true
      reported_infected_count 3
    end
    
    trait :create_inventory do
      after :create do |survivor|
        create :inventory, survivor_id: survivor.id
      end
    end   
  end
end