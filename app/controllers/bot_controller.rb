class BotController < ActionController::Base
  def hook
    # TODO: replace outdated lib
    bot_token = Rails.application.secrets.bot_token
    api = TelegramAPI.new bot_token

    chat_id = params[:message][:chat][:id]

    ast = CalculatorService.parse(params[:message][:text])
    message = ast.eval.to_s
  rescue Parslet::ParseFailed
    message = "Espressione non valida!"
  ensure
    api.sendMessage chat_id, message
  end
end
