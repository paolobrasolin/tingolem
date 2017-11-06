require "base64"
require "json"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if user_signed_in? and current_user.telegram_user_id.blank?
      serialized_payload = {
        user_id: current_user.id
      }

      @payload = Base64.urlsafe_encode64 serialized_payload.to_json

      puts serialized_payload

      puts @payload

      @deep_link = "https://telegram.me/titaniumabbot?start=#{@payload}"
      @qr_code = RQRCode::QRCode.new @deep_link, size: 4, level: :l
    end
  end
end
