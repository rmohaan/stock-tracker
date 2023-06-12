class StockController < ApplicationController
  
  def search
    stock_symbol = params[:stock]
    if stock_symbol.present?
      @stock = Stock.find_stock(stock_symbol)
      if @stock
        respond_to do |format|
          format.js { render partial: 'stock/result' }
        end
      else
        @stock = Stock.stock_symbol_lookup(stock_symbol)
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
