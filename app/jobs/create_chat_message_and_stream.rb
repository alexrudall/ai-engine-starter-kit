class CreateChatMessageAndStream < SidekiqJob
  def perform(args)
    chat_id, user_id, content, model = args.values_at("chat_id", "user_id", "content", "model")

    # Find the user.
    user = User.find(user_id)

    # Find the chat.
    chat = user.chats.find(chat_id)

    # Create the new user message.
    chat.messages.create(content: content, role: "user")

    # Get the response from OpenAI.
    chat.run(model: model)
  end
end
