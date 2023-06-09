class Stock < ApplicationRecord

  def self.get_price(symbol) 
    client = IEX::Api::Client.new(
                publishable_token: Rails.application.credentials.iex[:publishable_key],
                secret_token: Rails.application.credentials.iex[:secret_key],
                endpoint: 'https://cloud.iexapis.com/v1'
              )
    client.price(symbol)
  end
end
