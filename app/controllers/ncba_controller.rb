class NcbaController < ApplicationController
    NO_PARAMS_ERROR = { error: 'Kindly pass all required parameters' }
    
    def account_opening
        render json: NO_PARAMS_ERROR
    end
    def credit_details
        render json: NO_PARAMS_ERROR
    end
    def credit_transfer
        render json: NO_PARAMS_ERROR
    end
    def mpesa_verification
        render json: NO_PARAMS_ERROR
    end
    def push_notif
        render json: NO_PARAMS_ERROR
    end
    def transaction_query; end
    def call; end
end
