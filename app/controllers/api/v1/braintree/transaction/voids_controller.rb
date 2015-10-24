class Api::V1::Braintree::Transaction::VoidsController < ApplicationController
  respond_to :json

  def create
    result = Braintree::Transaction.void(params.permit(:transaction_id)[:transaction_id])

    if result.success?
      transaction = result.transaction
      render json: { transaction: transaction_attributes(transaction) }, status: :created
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def transaction_attributes(braintree_transaction)
    {
      id: braintree_transaction.id,
      status: braintree_transaction.status
    }
  end
end
