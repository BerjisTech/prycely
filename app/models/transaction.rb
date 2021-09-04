# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :wallet

  def self.for_group(group_id, limit = 0, offset = 0)
    Transaction.where(group_id: group_id).limit(limit).offset(offset)
  end

  def self.total(group_id)
    Transaction.where(group_id: group_id).pluck("count(id)").first
  end
end
