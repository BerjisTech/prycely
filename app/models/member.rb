# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :account

  scope :select_my_group_data, lambda {
    select('members.id', 'groups.id', :name, :membership, :created_by, :group_id, :currency, :group_type)
  }
  scope :select_for_current_user, ->(user_id) { where(user_id: user_id) }
  scope :select_for_invites, lambda {
                               select(:id, :name, :membership, :created_by, :currency, :group_type, :group_id, :invited_by, 'members.created_at')
                             }

  ADMIN = ['admin'].freeze
  MANAGER = %w[admin secretary treasurer chairperson].freeze
  CAN_ADD_MEMBERS = %w[admin secretary chairperson].freeze
  STATUS = %w[pending approved denied derigestered].freeze
  class << self
    def is_admin(user_id, group_id)
      ADMIN.include? Designation.find(Member.find_by(user_id: user_id,
                                                     group_id: group_id).designation).name.downcase.to_s
    end

    def is_manager(user_id, group_id)
      MANAGER.include? Designation.find(Member.find_by(user_id: user_id,
                                                       group_id: group_id).designation).name.downcase.to_s
    end

    def can_add_members(user_id, group_id)
      CAN_ADD_MEMBERS.include? Designation.find(Member.find_by(user_id: user_id,
                                                       group_id: group_id).designation).name.downcase.to_s
    end

    def is_in_group(user, group_id)
      @check = Member.where(user_id: user).where(group_id: group_id)
      result = if @check.count.positive?
                 true
               else
                 false
               end
    end

    def for_group(group_id, limit = 0, offset = 0)
      members = Member.where(group_id: group_id).where(status: '1').joins(user: :accounts)
      member_limit = if limit.to_i.zero?
                       members.count
                     else
                       limit
                     end
      members.limit(member_limit).offset(offset)
      members.select(
        "concat_ws(' ', first_name, last_name) AS full_names", :first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation
      )
    end

    def total_members(group_id)
      Member.where(group_id: group_id).pluck('count(id)').first
    end

    def status(status)
      STATUS[status]
    end

    def savings(group_id, user_id)
      Transaction.where(group_id: group_id, user_id: user_id, status: 1, level: 1,
                        transaction_type: 1).pluck('SUM(amount)').first || 0
    end
  end
end
