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

  end
end