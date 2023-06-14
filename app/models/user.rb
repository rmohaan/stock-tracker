class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_stock_under_limit?
    stocks.count < 10
  end

  def is_user_tracking_this_stock?(symbol)
    stock = Stock.find_stock(symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def can_allow_tracking?(symbol)
    is_stock_under_limit? && !is_user_tracking_this_stock?(symbol)
  end

  def full_name
   return "#{first_name} #{last_name}" if first_name || last_name
   "Anonymous"
  end

  def is_friend?(user)
    friends.include? user
  end

  def exclude(users)
    users.reject { |user| user.id == self.id}
  end

end
