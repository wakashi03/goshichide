class SenryuRankingService
  def self.ranked_by_favorites
    all_senryus = Senryu.where('favorites_count > 0').order(favorites_count: :desc)
    rank = 0
    ranked_senryus = all_senryus.chunk { |senryu| senryu.favorites_count }
                                .flat_map do |favorites_count, senryus|
                                  rank += 1
                                  senryus.map { |senryu| [rank, senryu] }
                                end
    ranked_senryus.take_while { |rank, _senryu| rank <= 3 }
  end
end