require 'amazon/ecs'

class AmazonSearch
  include ActiveSupport


  def test_search(search_word)

    Amazon::Ecs.options = {
      :associate_tag => ENV['picopico09-22'],
      :AWS_access_key_id => ENV['AKIAJUBRPFKTNJBB7FNA'],
      :AWS_secret_key => ENV['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']
    }

    res = Amazon::Ecs.item_search(search_word,
                            :search_index => 'Books',
                            :response_group => 'Medium',
                            :country => 'jp'
    )
    return res
  end

end
