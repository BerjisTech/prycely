# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :members
  has_many :loans
  has_many :loancategories
  has_many :projects
  has_many :transactions
  has_many :paymentcategories
  has_many :assets
  has_many :liabilities
  has_many :activities
  has_many :invites
  has_many :redeems
  has_many :logs

  def self.credit(group_id)
    Transaction.where(group_id: group_id).where(transaction_type: 1).pluck('sum(amount)').first || 0
  end

  def self.debit(group_id)
    Transaction.where(group_id: group_id).where(transaction_type: 2).pluck('sum(amount)').first || 0
  end

  def self.balance(group_id)
    credit(group_id) - debit(group_id)
  end

  def self.mine(user_id, limit = 10, offset = 0)
    Member.limit(limit).offset(offset).order(created_at: :desc).where.not(status: '0').where(user_id: user_id).joins(:group).select_my_group_data
  end

  def self.me(user_id, group_id)
    Member.find_by(user_id: user_id, group_id: group_id)
  end

  def self.check_account(user_id, group_id, user_email, account, group)
    account_check = Member.where(group_id: group_id)

    if account_check.count.zero? || account_check.length.zero? || account_check.empty? || account_check.nil?
      create_group_admin(user_id, group_id, account, group)
    else
      me = Group.me(user_id, group_id)
      stop_unwanted_user(me, group_id, user_email)
    end
  end

  def self.create_group_admin(user_id, group_id, account, group)
    if user_id == group.created_by
      admin_account = Member.new(invited_by: user_id, user_id: user_id,
                                 group_id: group_id, designation: 'admin', status: '1', invited_on: DateTime.now, accepted_on: DateTime.now, paid_member: '', amount: 0, account_id: account.first)

      if admin_account.save
        respond_to do |format|
          format.html { redirect_to group_url(group_id), notice: 'Your admin account has succsefully been set up' }
          format.json { head :no_content }
        end
      else
        render json: admin_account.errors
      end
    end
  end

  def self.stop_unwanted_user(me, group_id, user_email)
    redirect_to dashboard_path, notice: "You tried accessing a group you're not a member of" if me.nil?
    if me.status == '0'
      invite_check = Invite.find_by(invite_email: user_email, group_id: group_id)

      if invite_check.nil?
        redirect_to dashboard_path, notice: 'This invite key is invalid'
      else
        session[:invite_key] = invite_check.invite_key
      end
    end
  end
end
