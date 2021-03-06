class Api::V1::Braintree::Transaction::SalesController < ApplicationController
  respond_to :json

  def create
    result = Braintree::Transaction.sale(sale_params)

    if result.success?
      transaction = result.transaction
      render json: { transaction: transaction_attributes(transaction) }, status: :created
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.permit(
      :amount, :payment_method_token, :service_fee_amount, :customer_id, :merchant_account_id,
      options: [:submit_for_settlement, :hold_in_escrow]
    )
  end

  def transaction_attributes(braintree_transaction)
    {
      id: braintree_transaction.id,
      status: braintree_transaction.status
    }
  end
end
