namespace :senryu do
  desc "Send daily ranking via LINE"
  task send_ranking: :environment do
    # SenryuRankingServiceを使用してランキング情報を取得
    senryus = SenryuRankingService.ranked_by_favorites
    # ランキング情報をLINEで送信可能な形式に整形
    message = format_message(senryus)

    # LINE Botの設定を初期化
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end

    # "line"プロバイダーで認証された全ユーザーに対してメッセージを送信
    Authentication.where(provider: "line").find_each do |auth|
      # 各ユーザーのLINEユーザーID（uid）を使用してメッセージを送信
      response = client.push_message(auth.uid, { type: 'text', text: message })
      puts response.body
    end
  end

  # ランキング情報をLINEで送信可能なテキスト形式に整形するメソッド
  def format_message(senryus)
    senryus.each_with_index.map do |(_index, senryu), i|
      "#{i + 1}位: #{senryu.kamigo} #{senryu.nakashichi} #{senryu.shimogo} (お気に入り数: #{senryu.favorites_count})"
    end.join("\n")
  end
end
