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

  # protected

  # def confirmation_required?
  #   false
  # end
end
