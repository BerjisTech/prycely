# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :account

  scope :select_my_group_data, lambda {
    select('members.id', 'groups.id', :name, :membership, :created_by, :group_id, :currency, :group_type)
  }
  scope :select_for_current_user, ->(user_id) { where(user_id: user_id) }
  scope :select_for_invites, -> { select(:id, :name, :membership, :created_by, :currency, :group_type, :group_id) }

  ADMIN = ['admin'].freeze
  MANAGER = %w[admin secretary treasurer].freeze

  def self.is_admin(user_id)
    ADMIN.include? Member.find_by(user_id: user_id).designation.to_s
  end

  def self.is_manager(user_id)
    MANAGER.include? Member.find_by(user_id: user_id).designation.to_s
  end

  def self.for_group(group_id, limit = 0, offset = 0)
    members = Member.where(group_id: group_id)
    member_limit = if limit.to_i.zero?
      limit
    else
      members.count
    end
    members.limit(member_limit).offset(offset)
  end

  def self.total_members(group_id)
    Member.where(group_id: group_id).pluck('count(id)').first
  end
end
