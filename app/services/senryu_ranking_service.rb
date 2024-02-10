class SenryuRankingService
  def self.ranked_by_favorites
    all_senryus = Senryu.all.select { |senryu| senryu.favorites_count > 0 }
                  .group_by(&:favorites_count)
                  .sort_by { |favorites_count, _senryus| -favorites_count }
                  .flat_map.with_index(1) do |(_favorites_count, senryus), index|
                    senryus.map { |senryu| [index, senryu] }
                  end
    all_senryus.take_while { |rank, _senryu| rank <= 3 }
  end
end