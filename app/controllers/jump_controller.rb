class JumpController < ApplicationController
  def index
    $chat_id = params[:format]
    redirect_to '/chat_comments/index'
  end
end
