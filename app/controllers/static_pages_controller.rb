require 'flickraw'

class StaticPagesController < ApplicationController
  def home
    @pictures = []
    @links = []
    if !params[:id].nil?
      list = flickr.photos.search(:user_id => params[:id])
      list.each do |pic|
        @links << "https://www.flickr.com/photos/#{pic["owner"]}/#{pic["id"]}"     
        @pictures << URI.parse("http://farm#{pic["farm"]}.staticflickr.com/#{pic["server"]}/#{pic["id"]}_#{pic["secret"]}.jpg")
      end
    end
    render "static_pages/home"
  end
end