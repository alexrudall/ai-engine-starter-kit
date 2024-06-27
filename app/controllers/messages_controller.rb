class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    if message_params[:assistant_thread_id].present?
      CreateAssistantMessageAndRun.perform_async(
        "assistant_thread_id" => message_params[:assistant_thread_id],
        "storyteller_id" => message_params[:storyteller_id],
        "content" => message_params[:content],
        "user_id" => current_user.id
      )
    else
      CreateChatMessageAndStream.perform_async(
        "chat_id" => message_params[:chat_id],
        "content" => message_params[:content],
        "model" => message_params[:model],
        "user_id" => current_user.id
      )
    end

    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:assistant_thread_id, :chat_id, :content, :model, :storyteller_id)
  end
end
