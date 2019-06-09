
class TradeService
  class << self
    def is_valid?(trade_data)      
      !(trade_data[:survivor1][:infected] || trade_data[:survivor2][:infected]) && 
      (get_total_points_by_survival(trade_data[:resources1]) == get_total_points_by_survival(trade_data[:resources2]))     
    end

    def get_total_points_by_survival(resources) 
      total_points = 0

      resources.each do |resource|
        total_points += resource[:amount].to_i * INVENTORY_ENUM[resource[:name]]
      end    

      total_points
    end    
    
    def change_trade(trade_data)     
      trade_data[:survivor1].make_trade(trade_data[:survivor2], trade_data[:resources1])
      trade_data[:survivor2].make_trade(trade_data[:survivor1], trade_data[:resources2])
    end
  end
end