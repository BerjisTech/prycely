class GroupAsset < ApplicationRecord
    belongs_to :group
    belongs_to :user
    has_rich_text :description
end
