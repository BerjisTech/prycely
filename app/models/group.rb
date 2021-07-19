class Group < ApplicationRecord
  has_many :members, through: :user
  has_many :loans
  has_many :loancategories
  has_many :projects
  has_many :transactions
  has_many :paymentcategories
  has_many :assets
  has_many :liabilities
  belongs_to :grouptype
end
