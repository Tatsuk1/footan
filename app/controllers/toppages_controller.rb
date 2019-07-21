class ToppagesController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'
  
  def index
     
    if params[:search].present?
      
      base_url='https://api.gnavi.co.jp/RestSearchAPI/v3'
      p freeword = params[:search]
      
      parameters = {
        'freeword' => freeword,
        'format' => 'json',
        'keyid' => '11ca4c37d610e4a7ed0880bcfa8ff006'
      }
      
      p uri = URI(base_url + '?' + parameters.to_param)
      
      p response_json = Net::HTTP.get(uri)
      
      p response_data = JSON.parse(response_json)
      
      @rests = response_data['rest']
    end
  end
end
