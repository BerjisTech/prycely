class Invite < ApplicationRecord
    has_many :redeems
    belongs_to :group
end
