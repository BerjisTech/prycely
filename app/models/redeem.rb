class Redeem < ApplicationRecord
  belongs_to :invite
  belongs_to :user
  belongs_to :group
end
