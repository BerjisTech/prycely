# frozen_string_literal: true

class Invite < ApplicationRecord
  has_many :redeems
  belongs_to :group
  belongs_to :user

  class << self
    def mine(user_id)
      Member.where(status: '0').where(user_id: user_id).joins(:group).select_for_invites
    end

    def details(invite_key)
      Invite.where(invite_key: invite_key).joins(:group).joins(user: :accounts).select(
        :id,
        :first_name,
        :name,
        :email,
        :group_id,
        :group_type,
        :description,
        :user_id,
        :total_redeemed
      ).first
    end

    def update_invite(invite_key)
      @invite_update = Invite.where(invite_key: invite_key)
      if @invite_update.update_all(total_redeemed: @new_redeem_count)
        session.delete(:invite_key)
        redirect_to @group, notice: "You have succesfully joined #{@group.name}"
      else
        render json: @invite_update.errors
      end
    end
end
end
