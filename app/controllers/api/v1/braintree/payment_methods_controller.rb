class Api::V1::Braintree::PaymentMethodsController < ApplicationController
  respond_to :json

  def create
    result = Braintree::PaymentMethod.create(payment_method_params)

    if result.success?
      payment_method = result.payment_method
      render json: { payment_method: payment_method_attributes(payment_method) }, status: :created
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def payment_method_params
    params.permit(:customer_id, :payment_method_nonce)
  end

  def payment_method_attributes(payment_method)
    {
      token: payment_method.token,
      last_4: payment_method.last_4,
      image_url: payment_method.image_url,
      card_type: payment_method.card_type
    }
  end
end
