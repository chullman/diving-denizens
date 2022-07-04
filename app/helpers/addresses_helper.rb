module AddressesHelper

    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'

    def fetch(uri_str, header_key, header_value, limit = 10)
        
        raise ArgumentError, 'too many HTTP redirects' if limit == 0
        
    
        http = Net::HTTP.new(uri_str.host, uri_str.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri_str)
        request[header_key] = header_value

        response = http.request(request)
    
        case response
        when Net::HTTPSuccess then

            response.body
    
        
        when Net::HTTPRedirection then
            location = response['location']
            logger.debug "redirected to #{location}"
            fetch(location, limit - 1)
        else
            response.body
        end
    end

     # Try to parse a full string as JSON and return it all as as an array
     def try_parse_json(json_string)

        json_results = JSON.parse(json_string)

        # This block will be raised if the file only contains the string "[]" or "{}"
        if json_results.empty?
            logger.debug "ERROR: The JSON syntax is valid, but it is empty of content"
            return nil
        else
            return json_results
        end

    end

end
