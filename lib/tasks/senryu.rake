namespace :senryu do
  desc "Send daily ranking via LINE"
  task send_ranking: :environment do
    senryus = SenryuRankingService.ranked_by_favorites
    message = format_message(senryus)

    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end

    Authentication.where(provider: "line").find_each do |auth|
      response = client.push_message(auth.uid, { type: 'text', text: message })
      puts response.body
    end
  end
end

def format_message(senryus)
  senryus.each_with_index.map do |(rank, senryu), i|
    "#{rank}位: #{senryu.kamigo} #{senryu.nakashichi} #{senryu.shimogo} (お気に入り数: #{senryu.favorites_count})"
  end.join("\n")
end