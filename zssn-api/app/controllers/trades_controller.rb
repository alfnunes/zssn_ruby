class TradesController < ApplicationController
  def trade
    begin
      trade_data = parse_trade      
    rescue ActiveRecord::RecordNotFound
      return render json: { message: "Survivor doesn't exist" }, status: :not_found
    end

    begin
      if TradeService.is_valid?(trade_data)       
        TradeService.change_trade(trade_data)
        render json: { message: "Trade has finished!!" }
      else
        render json: { message: "There is a Survivor infected or maybe the points of resource is not equal" }, status: 400
      end
    rescue NoMethodError
      render json: { message: "Resource not found" }
    end

  end

  private
    def trade_params
      params.require(:trade).permit(survivor_1: [:id, resources: [:resource_id, :name, :amount]],
                                    survivor_2: [:id, resources: [:resource_id, :name, :amount]])
    end

    def parse_trade
      {
        survivor1: Survivor.find(trade_params[:survivor_1][:id]),
        survivor2: Survivor.find(trade_params[:survivor_2][:id]),
        resources1: trade_params[:survivor_1][:resources],
        resources2: trade_params[:survivor_2][:resources]
      }
    end

   
end