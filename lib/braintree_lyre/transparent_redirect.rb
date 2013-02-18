require 'braintree_lyre/transparent_redirect/create_transaction'
require 'braintree_lyre/helpers'

module BraintreeLyre

  module TransparentRedirect

    extend BraintreeLyre::Helpers

    def self.create(params)
      matches = params['tr_data'].match(/
        ^                 #start at the beginning
        .*                #match anything
        &kind=            #match the key we are looking for
        (?<kind>[^&]+)    #match the value and name it type
        &                 #match the terminating ampersand
        .*                #match anything
        $                 #match to the end
      /x)

      kind = matches['kind']
      klass = kind_to_class(kind)

      klass.new(params)
    end

    private

    def self.kind_to_class(kind)
      constantize("BraintreeLyre::TransparentRedirect::#{camelize(kind)}")
    end

  end

end