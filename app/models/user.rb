class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :registerable, :confirmable

  has_many :wallets
  has_many :groups
  has_many :transactions
  has_many :loans
  has_many :logins
  has_many :accounts
  has_many :members
  has_many :redeems
  has_many :invites

  # protected

  # def confirmation_required?
  #   false
  # end
end
