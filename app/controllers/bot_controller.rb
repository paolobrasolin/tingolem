class BotController < ActionController::Base
  def hook
    # TODO: replace outdated lib
    bot_token = Rails.application.secrets.bot_token
    api = TelegramAPI.new bot_token

    chat_id = params[:message][:chat][:id]

    params[:message][:text].match /^(?<command>\/\w+)(?<body>.*)/
    match = Regexp.last_match

    case match&.[](:command)
    when '/calc'
      ast = CalculatorService.parse match[:body].squish
      message = ast.eval.to_s
    when nil
      # nop
    else
      # nop
    end
  rescue Parslet::ParseFailed
    message = "Espressione non valida!"
  ensure
    api.sendMessage chat_id, message if message.present?
  end
end
