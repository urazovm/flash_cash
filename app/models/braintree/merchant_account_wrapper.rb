class Braintree::MerchantAccountWrapper
  def initialize(merchant_account)
    @merchant_account = merchant_account
  end

  def to_json
    attributes.to_json
  end

  def attributes
    {
      id: @merchant_account.id,
      status: @merchant_account.status,
      master_merchant_account: {
        id: @merchant_account.master_merchant_account.id,
        status: @merchant_account.master_merchant_account.status,
        master_merchant_account: @merchant_account.master_merchant_account.master_merchant_account
      }
    }
  end
end
