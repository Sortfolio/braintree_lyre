require 'spec_helper'
require 'braintree'

describe "Setup" do
  
  before(:each) do
    @lyre = BraintreeLyre::Lyre.boot
  end

  after(:each) do
    @lyre.shutdown
  end

  it "should override the Braintree configuration when the lyre is started" do
    Braintree::Configuration.environment.should == :development
    Braintree::Configuration.merchant_id.should == '0000'
    Braintree::Configuration.public_key.should == 'pubkey'
    Braintree::Configuration.private_key.should == 'prikey'
    ENV.should have_key('GATEWAY_PORT')
  end

end