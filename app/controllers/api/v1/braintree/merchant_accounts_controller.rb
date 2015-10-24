class Api::V1::Braintree::MerchantAccountsController < ApplicationController
  respond_to :json

  def create
    result = Braintree::MerchantAccount.create(merchant_account_params)

    if result.success?
      merchant_account = Braintree::MerchantAccountWrapper.new(result.merchant_account)
      render json: { merchant_account: merchant_account.attributes }, status: :created
    else
      render json: { error: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def merchant_account_params
    params.permit(
      :tos_accepted, :master_merchant_account_id, :id,
      individual: [
        :first_name, :last_name, :email, :phone, :date_of_birth, :ssn,
        address: [ :street_address, :locality, :region, :postal_code ]
      ],
      business: [
        :legal_name, :dba_name, :tax_id,
        address: [
          :street_address, :locality, :region, :postal_code
        ]
      ],
      funding: [
        :descriptor, :destination, :email, :mobile_phone, :account_number, :routing_number
      ]
    )
  end
end
