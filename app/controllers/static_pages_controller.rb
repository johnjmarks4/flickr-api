require 'flickraw'
require 'net/http'

class StaticPagesController < ApplicationController
  def home
    uri = URI("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bb736be313aacbbe7303ee482b70cf72&user_id=154081774@N08&photo_id=38248756761")  
    response = Net::HTTP.get(uri)
    response = Hash.from_xml(response)
    response = response["rsp"]["photos"]["photo"][0]
    @picture = URI.parse("http://farm#{response["farm"]}.staticflickr.com/#{response["server"]}/#{response["id"]}_#{response["secret"]}.jpg")
    render "static_pages/home"
  end
end