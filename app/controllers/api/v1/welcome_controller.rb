class Api::V1::WelcomeController < ApplicationController
  def index
    render json: {response: "<@#{params['user_id']}> #{params['text']}"}
  end
end
