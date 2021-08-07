# frozen_string_literal: true

json.extract! project, :id, :title, :description, :amount, :status, :project_start, :project_end, :created_by,
              :group_id, :currency, :created_at, :updated_at
json.url project_url(project, format: :json)
