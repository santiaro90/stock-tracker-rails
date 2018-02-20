class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  def self.search(q)
    to_search = q.strip.downcase

    where('first_name like :q or last_name like :q or email like :q',
          q: "%#{to_search}%")
  end

  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name
    'Anonymous'
  end

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

  def friends_with?(user)
    friendships.find_by(friend_id: user.id)
  end
end
