class StockController < ApplicationController
  
  def search
    if params[:stock].present?
      @stock = Stock.stock_symbol_lookup(params[:stock])
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
