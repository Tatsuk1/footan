require 'net/http'
require 'json'
require 'uri'

API_BASE_URL='https://api.gnavi.co.jp/RestSearchAPI/v3'

freeword = ARGV[0] || 'Ruby'
params = {
  'freeword' => URI.encode(freeword),
  'format' => 'json',
  'keyid' =>'11ca4c37d610e4a7ed0880bcfa8ff006'
}

uri = URI(API_BASE_URL + '?' + params.map{|k,v| "#{k}=#{v}"}.join('&'))

response_json = Net::HTTP.get(uri)

response_data = JSON.parse(response_json)

@rests = response_data['rest']

response_data['rest'].each do |d|
#   @id = 'id'
#   @name = 'name'
#   @latitude = 'latitude'
#   @longitude = 'longitude'
#   @shop_url = 'shop_url'
#   @image_url = 'image_url'
#   @address = 'address'
#   @tel = 'tel'
#   @opentime = 'opentime'
#   @holiday = 'holiday'
 puts d['name'], d['image_url'], d['address'], d['opentime'], d['holiday']
 end