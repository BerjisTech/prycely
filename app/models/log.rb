# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  belongs_to :group

  def self.mine(user_id, limit = 0, offset = 0)
    Log.where(user_id: user_id).limit(limit).offset(offset)
  end

  def self.for_group(wallet_id, limit = 0, offset = 0)
    Log.where(wallet_id: wallet_id).limit(limit).offset(offset)
  end

  def self.for_group(group_id, limit = 0, offset = 0)
    Log.where(group_id: group_id).limit(limit).offset(offset)
  end

  def self.last_of_mine(user_id)
    log = Log.where(user_id: user_id).limit(1).order(created_at: :desc)[0]
    last_log(log)
  end

  def self.last_of_group(wallet_id)
    log = Log.where(wallet_id: wallet_id).limit(1).order(created_at: :desc)[0]
    last_log(log)
  end

  def self.last_of_group(group_id)
    log = Log.where(group_id: group_id).limit(1).order(created_at: :desc)[0]
    last_log(log)
  end

  def self.last_log(last_log)
    if @last_log.present?
      "Last activity at #{@last_log.created_at.strftime('%d %M, %Y')}"
    else
      "No activities yet"
    end
  end
end
