require "base64"
require "json"

class BotController < ActionController::Base


  def hook
    # TODO: replace outdated lib
    # https://core.telegram.org/bots#deep-linking
    bot_token = Rails.application.secrets.bot_token
    api = TelegramAPI.new bot_token

    chat_id = params[:message][:chat][:id]

    params[:message][:text].match /^(\/(?<command>\w+) )?(?<body>.*)/
    match = Regexp.last_match

    case match&.[](:command)
    when 'calc'
      ast = CalculatorService.parse match[:body].squish
      message = ast.eval.to_s
    when 'start'
      serialized_payload = JSON.parse Base64.urlsafe_decode64(match[:body])
      User.find(serialized_payload[:user_id]).update! telegram_user_id: params[:from][:id]
      chat_id = params[:message][:chat][:id]
      message = "You have been recognized."
    else
      # nop
    end
  rescue Parslet::ParseFailed
    message = "Espressione non valida!"
  ensure
    api.sendMessage chat_id, message if message.present?
  end
end
