class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!

  def create
    CreateMessageAndRun.new.perform(
      "assistant_thread_id" => params["assistant_thread_id"],
      "storyteller_id" => message_params[:storyteller_id],
      "content" => message_params[:content],
      "user_id" => current_user.id
    )

    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:storyteller_id, :content)
  end
end
