FactoryGirl.define do
  factory :resource do
    factory :resource_ammunition do
      point 1
      name 'Ammunition'
    end 

    factory :resource_medication do
      point 2
      name 'Medication'
    end

    factory :resource_food do
      point 3
      name 'Food'
    end

    factory :resource_water do
      point 4
      name 'Water'
    end
  end
end