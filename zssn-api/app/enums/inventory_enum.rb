class INVENTORY_ENUM < ActiveEnum::Base
  value 1 => ConstantHelper::Ammunition
  value 2 => ConstantHelper::Medication
  value 3 => ConstantHelper::Food
  value 4 => ConstantHelper::Water
end