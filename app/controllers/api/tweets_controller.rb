class Api::TweetsController < ApplicationController
  require 'net/http'
  require 'json'

  def create
    @picture = Picture.find(params[:picture_id])

    uri = URI.parse("https://arcane-ravine-29792.herokuapp.com/api/tweets")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"

    params = { 
      text: @picture.title,
      url: url_for(@picture.image)
    }

    headers = { "Content-Type" => "application/json", "authorization" => "Bearer #{session[:access_token]}"}
    response = http.post(uri.path, params.to_json, headers)
    byebug

    add_flash_message :notice, 'ツイートにしました' if response.code.to_i == 201
    redirect_to pictures_path
  rescue Exception => e
    add_flash_message :alert, 'ツイートに失敗しました。'
  end
end
