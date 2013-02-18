require 'braintree'
require 'lyre'

module BraintreeLyre
  class Lyre < Lyre::App

    ENVIRONMENT = :development
    MERCHANT_ID = "0000"
    PUBLIC_KEY = "pubkey"
    PRIVATE_KEY = "prikey"

    setup do |lyre|
      Braintree::Configuration.environment = BraintreeLyre::Lyre::ENVIRONMENT
      Braintree::Configuration.merchant_id = BraintreeLyre::Lyre::MERCHANT_ID
      Braintree::Configuration.public_key  = BraintreeLyre::Lyre::PUBLIC_KEY
      Braintree::Configuration.private_key = BraintreeLyre::Lyre::PRIVATE_KEY
      ENV['GATEWAY_PORT'] = lyre.port.to_s
    end

    # Braintree::TransparentRedirect.url
    post "/merchants/:merchant_id/transparent_redirect_requests" do
      debugger
      "REDIRECT REQUEST"
    end

    # Braintree::TransparentRedirect.confirm
    post "/merchants/:merchant_id/transparent_redirect_requests/:id/confirm" do
      debugger
      "REDIRECT CONFIRM"
    end

    post '/*' do
      debugger
      "DEFAULT POST"
    end

    get '/*' do
      debugger
      "DEFAULT GET"
    end

  end
end