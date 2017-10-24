class BotController < ActionController::Base
  def hook
    bot_token = Rails.application.secrets.bot_token
    api = TelegramAPI.new bot_token

    api.sendMessage params[:message][:chat][:id],
                    params[:message][:text]
  end
end
