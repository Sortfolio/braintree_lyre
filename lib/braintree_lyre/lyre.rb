require 'braintree'
require 'lyre'

module BraintreeLyre
  class Lyre < Lyre::App

    include BraintreeLyre::Helpers

    ENVIRONMENT = :development
    MERCHANT_ID = "0000"
    PUBLIC_KEY = "pubkey"
    PRIVATE_KEY = "prikey"

    attr_accessor :last_thing

    setup do |lyre|
      Braintree::Configuration.environment = BraintreeLyre::Lyre::ENVIRONMENT
      Braintree::Configuration.merchant_id = BraintreeLyre::Lyre::MERCHANT_ID
      Braintree::Configuration.public_key  = BraintreeLyre::Lyre::PUBLIC_KEY
      Braintree::Configuration.private_key = BraintreeLyre::Lyre::PRIVATE_KEY
      ENV['GATEWAY_PORT'] = lyre.port.to_s
    end

    # Braintree::TransparentRedirect.url
    post "/merchants/:merchant_id/transparent_redirect_requests" do
      if params[:tr_data]
        transaction = TransparentRedirect.create(params)
        redirect to(transaction.return_url), 303
      else
        [422, { "Content-Type" => "text/html" }, ["Invalid submission"]]
      end
    end

    # Braintree::TransparentRedirect.confirm
    post "/merchants/:merchant_id/transparent_redirect_requests/:id/confirm" do
      hash = {
        :id=>params[:id],
        :status=>"submitted_for_settlement",
        :type=>"sale",
        :currency_iso_code=>"USD",
        :amount=>"99.00",
        :merchant_account_id=>params[:merchant_id],
        :order_id=>nil,
        :created_at=>'2013-02-19 20:19:41 UTC',
        :updated_at=>'2013-02-19 20:19:41 UTC',
        :customer=>{
          :id=>"9807292",
          :first_name=>nil,
          :last_name=>nil,
          :company=>nil,
          :email=>nil,
          :website=>nil,
          :phone=>nil,
          :fax=>nil
        },
        :billing=>{
          :id=>"r2",
          :first_name=>nil,
          :last_name=>nil,
          :company=>nil,
          :street_address=>nil,
          :extended_address=>nil,
          :locality=>nil,
          :region=>nil,
          :postal_code=>"02446",
          :country_name=>nil,
          :country_code_alpha2=>nil,
          :country_code_alpha3=>nil,
          :country_code_numeric=>nil
        },
        :refund_id=>nil,
        :refund_ids=>[],
        :refunded_transaction_id=>nil,
        :settlement_batch_id=>nil,
        :shipping=>{
          :id=>nil,
          :first_name=>nil,
          :last_name=>nil,
          :company=>nil,
          :street_address=>nil,
          :extended_address=>nil,
          :locality=>nil,
          :region=>nil,
          :postal_code=>nil,
          :country_name=>nil,
          :country_code_alpha2=>nil,
          :country_code_alpha3=>nil,
          :country_code_numeric=>nil
        },
        :custom_fields=>"\n  ",
        :avs_error_response_code=>nil,
        :avs_postal_code_response_code=>"M",
        :avs_street_address_response_code=>"I",
        :cvv_response_code=>"I",
        :gateway_rejection_reason=>nil,
        :processor_authorization_code=>"HWR67T",
        :processor_response_code=>"1000",
        :processor_response_text=>"Approved",
        :purchase_order_number=>nil,
        :tax_amount=>nil,
        :tax_exempt=>false,
        :credit_card=>{
          :token=>"7tndh",
          :bin=>"411111",
          :last_4=>"1111",
          :card_type=>"Visa",
          :expiration_month=>"01",
          :expiration_year=>"2018",
          :customer_location=>"US",
          :cardholder_name=>nil,
          :prepaid=>"Unknown",
          :healthcare=>"Unknown",
          :debit=>"Unknown",
          :durbin_regulated=>"Unknown",
          :commercial=>"Unknown",
          :payroll=>"Unknown",
          :issuing_bank=>"Unknown",
          :country_of_issuance=>"Unknown"
        },
        :status_history=>[
          {:timestamp=>'2013-02-19 20:19:41 UTC', :status=>"authorized", :amount=>"99.00", :user=>"sortfolio_sandbox", :transaction_source=>"API"},
          {:timestamp=>'2013-02-19 20:19:41 UTC', :status=>"submitted_for_settlement", :amount=>"99.00", :user=>"sortfolio_sandbox", :transaction_source=>"API"}
        ],
        :plan_id=>nil,
        :subscription_id=>nil,
        :subscription=>{
          :billing_period_end_date=>nil,
          :billing_period_start_date=>nil
        },
        :add_ons=>[],
        :discounts=>[],
        :descriptor=>{
          :name=>nil,
          :phone=>nil
        },
        :recurring=>false,
        :channel=>nil
      }

      gzipped_response(201, hash.to_xml(:root => 'transaction'))
    end

  end
end

