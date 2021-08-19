# frozen_string_literal: true

json.array! @errors, partial: 'errors/error', as: :error
