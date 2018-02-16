class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def tracking?(ticker)
    stock = Stock.find_by_ticker(ticker)

    return false unless stock

    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    user_stocks.count < 10
  end

  def can_track?(ticker)
    under_stock_limit? && !tracking?(ticker)
  end
end
