require 'amazon/ecs'

class AmazonSearch
  include ActiveSupport


  def self.search_all(search_word)

    text = ''
    begin
      res = _search(search_word)
      if res.items.size > 0
        res.items.each do |item|
          # puts item.get_element('ItemAttributes')
          text = text + "Title:#{item.get('ItemAttributes/Title')}\nURL:#{_create_affiliate_url(item.get('ASIN'))}\n\n"
          # puts "Title:#{item.get('ItemAttributes/Title')}"
          # puts "URL:#{create_url(item.get('ASIN'))}"
          # puts item.get_hash('SmallImage')
        end
      else
        text = 'みつからないわね...'
      end
    rescue Amazon::RequestError => ex
      puts ex.message
      text = '今、混雑中だわ....'
    end
    return text
  end

  private
  def self._search(search_word)
    Amazon::Ecs.options = {
        :associate_tag => ENV['associate_tag'],
        :AWS_access_key_id => ENV['AWS_access_key_id'],
        :AWS_secret_key => ENV['AWS_secret_key']
    }
    return Amazon::Ecs.item_search(search_word,
                                   :search_index => 'All',
                                   :response_group => 'Medium',
                                   :country => 'jp'
    )
  end

  #http://www.amazon.co.jp/dp/ASINコード/?tag=アフィリエイトタグ
  def self._create_affiliate_url(asin_code)
    "http://www.amazon.co.jp/dp/#{asin_code}?tag=#{ENV['associate_tag']}"
  end

end
