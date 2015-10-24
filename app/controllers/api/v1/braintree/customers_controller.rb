class Api::V1::Braintree::CustomersController < ApplicationController
  respond_to :json

  def create
    result = Braintree::Customer.create(customer_params)

    if result.success?
      @customer_id = result.customer.id
      render json: { customer_id: @customer_id }
    else
      render json: { errors: result.errors }
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :company, :email, :phone, :fax, :website)
  end
end
