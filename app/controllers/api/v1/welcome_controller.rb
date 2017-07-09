class Api::V1::WelcomeController < ApplicationController
  def index
    render json: '開店準備中'
  end
end
