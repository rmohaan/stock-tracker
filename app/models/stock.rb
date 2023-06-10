class Stock < ApplicationRecord
  def self.get_price(symbol) 
    client = IEX::Api::Client.new(
                publishable_token: Rails.application.credentials.iex[:publishable_key],
                secret_token: Rails.application.credentials.iex[:secret_key],
                endpoint: 'https://cloud.iexapis.com/v1'
              )
    
    begin
      company_name = client.company(symbol).company_name
      stock_price = client.price(symbol)
      new(name: company_name, symbol: symbol, price: stock_price)
    rescue =>  exception
      return nil
    end
  end
end
