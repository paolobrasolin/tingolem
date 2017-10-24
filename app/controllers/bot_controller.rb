class BotController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:hook]

  def hook
  end
end
