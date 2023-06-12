class UserStocksController < ApplicationController

  def create
    current_stocks_count = current_user.stocks.count
    if current_stocks_count > 10
      flash[:alert] = "Stock watchlist limit exceeded, only 10 stocks can be watched"
      redirect_to my_stocks_path
    else
      symbol = params[:stock]
      stock = Stock.find_stock(symbol)
      if stock == nil
        stock = Stock.stock_symbol_lookup(symbol)
        if stock != nil
          stock.save
          UserStock.create(user: current_user, stock: stock)
          flash[:notice] = "Stock #{stock.name} added to table and watchlisted"
          redirect_to my_stocks_path
        else
          flash[:alert] = "Stock couldn't be added to table"
          redirect_to my_stocks_path
        end
      else
        UserStock.create(user: current_user, stock: stock)
        flash[:notice] = "Stock added to watchlist"
        redirect_to my_stocks_path
      end
    end

  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.name} has been removed from your watchlist"
    redirect_to my_stocks_path
  end
end
