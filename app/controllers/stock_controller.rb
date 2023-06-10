class StockController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if params[:stock].present?
      @stock = Stock.get_price(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'stock/result' }
        end
      else
        flash.now[:alert] = "Please enter a valid symbol to search"
        respond_to do |format|
          format.js { render partial: 'stock/result' }
        end
      end
    else
      flash.now[:alert] = "Please enter a symbol to search"
      respond_to do |format|
        format.js { render partial: 'stock/result' }
      end
    end
  end

  def add
    debugger
    puts params
  end

end
