class Group < ApplicationRecord
    has_many :members
    has_many :loans
    has_many :loancategories
    has_many :projects
    has_many :transactions
    has_many :users
    has_many :paymentcategories
    has_many :assets
    has_many :liabilities
end
