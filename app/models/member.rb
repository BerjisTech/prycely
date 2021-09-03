# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :account

  scope :select_my_group_data, -> { select('members.id', 'groups.id', :name, :membership, :created_by, :group_id, :currency, :group_type) }
  scope :select_for_current_user, ->(user_id) { where(user_id: user_id) }
  scope :select_for_invites, -> { select(:id, :name, :membership, :created_by, :currency, :group_type, :group_id) }

  def self.for_group(group_id, limit = 0, offset = 0)
    Member.where(group_id: group_id).limit(limit).offset(offset)
  end

  def self.total_members(group_id)
    Member.where(group_id: group_id).pluck('count(id)').first
  end
end
