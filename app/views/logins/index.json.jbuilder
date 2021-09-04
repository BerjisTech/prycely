# frozen_string_literal: true

json.array! @logins, partial: "logins/login", as: :login
