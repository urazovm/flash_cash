class Api::V1::Braintree::Transaction::ReleasesFromEscrowController < ApplicationController
  before_filter :force_settle_transaction, only: :create

  respond_to :json

  def create
    result = Braintree::Transaction.release_from_escrow(params.permit(:transaction_id)[:transaction_id])

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

  def force_settle_transaction
    # HACK: This is a forced settlement only for development mode
    #   A transaction must be settled before it can be released from escrow.
    Braintree::TestTransaction.settle(params.permit(:transaction_id)[:transaction_id])
  end
end
