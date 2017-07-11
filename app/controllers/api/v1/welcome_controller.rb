class Api::V1::WelcomeController < ApplicationController
  def index
    render json: {response: "@#{params['user_name']} #{params['text']}"}
  end
end
