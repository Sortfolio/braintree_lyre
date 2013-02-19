require 'zlib'
module BraintreeLyre

  module Helpers
    
    def gzip(content)
      StringIO.new.tap do |io|
        gz = Zlib::GzipWriter.new(io)
      
        begin
          gz.write(content)
        ensure
          gz.close
        end
      end.string
    end

    def gzipped_response(status_code, uncompressed_content)
      [status_code, { "Content-Encoding" => "gzip" }, gzip(uncompressed_content)]
    end

    def camelize(str)
      segments = str.split('_')

      segments.inject("") { |acc, s| acc << s.capitalize }
    end

    def constantize(camel_cased_word)
      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end

  end

end