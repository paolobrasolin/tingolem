class BotController < ActionController::Base
  def hook
    # TODO: replace outdated lib
    bot_token = Rails.application.secrets.bot_token
    api = TelegramAPI.new bot_token

    chat_id = params[:message][:chat][:id]

    result = CalculatorService.parse(params[:message][:text]).eval
    message = result
  rescue Parslet::ParseFailed
    message = "Espressione non valida!"
  ensure
    api.sendMessage chat_id, message
  end
end
