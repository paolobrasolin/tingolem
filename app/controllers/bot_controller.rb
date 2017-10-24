class BotController < ActionController::Base
  # {"update_id"=>488609468, "message"=>{"message_id"=>4, "from"=>{"id"=>238955633, "is_bot"=>false, "first_name"=>"Paolo", "last_name"=>"Brasolin", "language_code"=>"en-IT"}, "chat"=>{"id"=>238955633, "first_name"=>"Paolo", "last_name"=>"Brasolin", "type"=>"private"}, "date"=>1508873287, "text"=>"aaa"}, "bot"=>{"update_id"=>488609468, "message"=>{"message_id"=>4, "from"=>{"id"=>238955633, "is_bot"=>false, "first_name"=>"Paolo", "last_name"=>"Brasolin", "language_code"=>"en-IT"}, "chat"=>{"id"=>238955633, "first_name"=>"Paolo", "last_name"=>"Brasolin", "type"=>"private"}, "date"=>1508873287, "text"=>"aaa"}}}

  def hook
    bot_token = Rails.secrets.bot_token
    api = TelegramAPI.new bot_token

    api.sendMessage params[:message][:chat][:id],
                    params[:message][:text]
  end
end
