class Stock < ActiveRecord::Base
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

  def self.strip_commas(number)
    number.delete(',')
  end
end
