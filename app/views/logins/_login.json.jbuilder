# frozen_string_literal: true

json.extract! login, :id, :user_id, :time, :ip, :success, :password_attempt, :created_at, :updated_at
json.url login_url(login, format: :json)
