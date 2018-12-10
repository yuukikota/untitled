class JumpsController < ApplicationController
  def index
      $chat_id = params[:id]
      redirect_to '/chat_comments'
  end
end
