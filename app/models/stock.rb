class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    stock = StockQuote::Stock.quote(ticker_symbol)
    raise ActiveRecord::RecordNotFound unless stock

    price = strip_commas(stock.l)

    new(name: stock.name,
        ticker: stock.symbol,
        last_price: price)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.strip_commas(number)
    number.delete(',')
  end
end
