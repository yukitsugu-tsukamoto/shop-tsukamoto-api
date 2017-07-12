class Api::V1::WelcomeController < ApplicationController
  def index

    # Amazon::Ecs.debug = true
    Amazon::Ecs.options = {
      :associate_tag => ENV['associate_tag'],
      :AWS_access_key_id => ENV['AWS_access_key_id'],
      :AWS_secret_key => ENV['AWS_secret_key']
    }

    begin
      res = Amazon::Ecs.item_search(params['text'],
                                    :search_index => 'All',
                                    :response_group => 'Small',
                                    :country => 'jp',
                                    :limit => 3
      )
      text = ''
      res.items.each do |item|
        # puts item.get_element('ItemAttributes')
        text = text + "Title:#{item.get('ItemAttributes/Title')}\nURL:#{create_url(item.get('ASIN'))}\n\n"


        puts "Title:#{item.get('ItemAttributes/Title')}"
        puts "URL:#{create_url(item.get('ASIN'))}"
        # puts item.get_hash('SmallImage')
      end
    rescue Amazon::RequestError => ex
      render json: { response: "<@#{params['user_id']}> 今、混雑中だわ...." }
    end


    render json: { response: "<@#{params['user_id']}> \n ```#{text}```" }
  end

  private
  #http://www.amazon.co.jp/dp/ASINコード/?tag=アフィリエイトタグ
  def create_url(asin_code)
    "http://www.amazon.co.jp/dp/#{asin_code}?tag=#{ENV['associate_tag']}"
  end
end
