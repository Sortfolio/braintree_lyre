require 'spec_helper'
require 'braintree_lyre'

describe "CreateTransaction" do

  subject(:tr) do
    BraintreeLyre::TransparentRedirect.create(
      {
        #"utf8"=>"✓",
        "tr_data"=>"f1fdad882a1b3e55fbb9d1efea9c2b6b31a1400e|api_version=2&kind=create_transaction&public_key=pubkey&redirect_url=http%3A%2F%2F127.0.0.1%3A51576%2Fsignup%2Fpro%2Fpublish&time=20130218050006&transaction%5Bamount%5D=99&transaction%5Boptions%5D%5Badd_billing_address_to_payment_method%5D=true&transaction%5Boptions%5D%5Bstore_in_vault_on_success%5D=true&transaction%5Boptions%5D%5Bsubmit_for_settlement%5D=true&transaction%5Btype%5D=sale",
        "transaction"=> {
          "credit_card" => {
            "number"=>"4111-1111-1111-1111",
            "expiration_month"=>"1",
            "expiration_year" => "2015"
          },
          "billing" => {
            "postal_code"=>"02446"
          }
        },
        "x"=>"122",
        "y"=>"19",
        "splat"=>[],
        "captures"=>["0000"],
        "merchant_id"=>"0000"
      }
    )
  end

  specify { tr.should be_a(BraintreeLyre::TransparentRedirect::CreateTransaction) }
  specify { tr.merchant_id.should == '0000' }

end