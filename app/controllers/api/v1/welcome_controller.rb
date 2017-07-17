class Api::V1::WelcomeController < ApplicationController
  def index
    if params['user_name'] == 'tsujinaka'
      render json: {response: "<@#{params['user_id']}> あ？"}
    end

    text = ''
    search_word_tmp = params['text'].match(/(ほしい|がほしい|欲しい|が欲しい)$/)
    if search_word_tmp.present?
      text = AmazonSearch.search_all(params['text'].delete(search_word_tmp.to_s))
      render json: {response: "<@#{params['user_id']}> #{text}"}
    end
    return
  end

end
