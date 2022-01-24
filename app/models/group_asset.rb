# frozen_string_literal: true

class GroupAsset < ApplicationRecord
    belongs_to :group
    has_rich_text :description
end
