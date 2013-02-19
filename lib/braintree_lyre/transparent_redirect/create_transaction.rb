require 'digest/md5'

module BraintreeLyre::TransparentRedirect

  class CreateTransaction

    attr_reader :merchant_id, :redirect_url, :kind

    def initialize(params)
      _, query = *params['tr_data'].split("|", 2)
      tr_data = Rack::Utils.parse_query(query)

      @merchant_id = params['merchant_id']
      @redirect_url = tr_data['redirect_url']
      @kind = tr_data['kind']
    end

    def return_url
      query = base_query
      uri = URI.parse(redirect_url).merge("?#{query}&hash=#{hash(query)}")
      uri.to_s
    end

    private

    #MOVE TO HELPER?
    def base_query
      id = create_id(merchant_id)
      "http_status=200&id=#{id}&kind=#{kind}"
    end

    #MOVE TO HELPER?
    def hash(string)
      Braintree::Digest.hexdigest(Braintree::Configuration.private_key, string)
    end

    #MOVE TO HELPER?
    def create_id(merchant_id)
      Digest::MD5.hexdigest("#{merchant_id}#{Time.now.to_f}")
    end
  end

end