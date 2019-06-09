class Resource < ApplicationRecord
  has_many :inventory_resources
  has_many :inventories, through: :inventory_resources

  scope :withoutDate, -> () { select("id, name, point") }
end
