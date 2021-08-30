class Log < ApplicationRecord
    belongs_to :user
    belongs_to :wallet
    belongs_to :group
end
