json.extract! log, :id, :activity, :user_id, :wallet_id, :group_id, :created_at, :updated_at
json.url log_url(log, format: :json)
