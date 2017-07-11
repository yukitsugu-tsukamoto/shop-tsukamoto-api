class Api::V1::WelcomeController < ApplicationController
  def index
    render json: {response: 'とりあえず接続'}
  end
end
