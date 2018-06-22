require 'flickraw'

FlickRaw.api_key = '509167075411d066c75cb8b8e0a05b40'
FlickRaw.shared_secret = '20ca916612be59a6'

class StaticPagesController < ApplicationController
  def home
    @pictures = []
    @links = []
    begin
      if !params[:id].nil?
        list = flickr.photos.search(:user_id => params[:id])
        list.each do |pic|
          @links << "https://www.flickr.com/photos/#{pic["owner"]}/#{pic["id"]}"     
          @pictures << URI.parse("http://farm#{pic["farm"]}.staticflickr.com/#{pic["server"]}/#{pic["id"]}_#{pic["secret"]}.jpg")
        end
      end
    rescue
      flash[:alert] = "User not found"
      redirect_to root_path
    end
  end
end