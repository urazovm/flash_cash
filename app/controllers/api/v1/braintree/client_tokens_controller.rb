class Api::V1::Braintree::ClientTokensController < ApplicationController
  respond_to :json

  def create
    @client_token = Braintree::ClientToken.generate(params.permit(:customer_id))

    render json: { client_token: @client_token }
  end
end
