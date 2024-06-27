class CreateChatMessageAndStream < SidekiqJob
  def perform(args)
    chat_id, user_id, content, model = args.values_at("chat_id", "user_id", "content", "model")

    user = User.find(user_id)

    chat = user.chats.find(chat_id)

    chat.messages.create(content: content, role: "user")

    chat.run(model: model)
  end
end
