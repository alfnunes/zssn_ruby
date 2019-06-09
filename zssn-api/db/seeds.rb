# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Resource.first.nil? && (Rails.env = "Development" || Rails.env = "docker")

	1.times do
		Resource.create(
			name: 'Ammunition',
			point: 1
		)
		Resource.create(
			name: 'Medication',
			point: 2
		)
		Resource.create(
			name: 'Food',
			point: 3
		)
		Resource.create(
			name: 'Water',
			point: 4
		)
	end

	10.times  do
		survivor = Survivor.create({
			name: Faker::Name.unique.name,
			age: Faker::Number.between(15, 90),
			gender:Faker::Gender.binary_type,
			last_location:ActiveRecord::Point.new(Faker::Address.latitude , Faker::Address.longitude),
			infected: true,
			reported_infected_count: 3
		})

		inventory = Inventory.create({
			survivor_id: survivor.id
		})

		InventoryResource.create({
			inventory_id: inventory.id,
			resource_id: Resource.find_by_name('Water').id
		})

		InventoryResource.create({
			inventory_id: inventory.id,
			resource_id: Resource.find_by_name('Medication').id
		})
	end

	10.times  do
		survivor = Survivor.create({
			name: Faker::Name.unique.name,
			age: Faker::Number.between(15, 90),
			gender:Faker::Gender.binary_type,
			last_location:ActiveRecord::Point.new(-47.087616 , -22.908928),
			infected: false	
		})

		inventory = Inventory.create({
			survivor_id: survivor.id
		})

		InventoryResource.create({
			inventory_id: inventory.id,
			resource_id: Resource.find_by_name('Food').id
		})

		InventoryResource.create({
			inventory_id: inventory.id,
			resource_id: Resource.find_by_name('Ammunition').id
		})
	end
end