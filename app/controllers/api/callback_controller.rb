class Api::CallbackController < ApplicationController
  require 'net/http'

  def index
    uri = URI.parse("https://arcane-ravine-29792.herokuapp.com/oauth/token")
    request_body = { 
      code: params[:code],
      client_id: Rails.application.credentials.tweet_appli[:client_id],
      client_secret: Rails.application.credentials.tweet_appli[:client_secret],
      redirect_uri: Rails.application.credentials.tweet_appli[:redirect_uri],
      grant_type: 'authorization_code'
    }
    response = Net::HTTP.post_form(uri, request_body)
    session[:access_token] = JSON.parse(response.body)["access_token"]
    redirect_to pictures_path
  end

  private

  def token_params
    params.permit(:code)
  end

end
