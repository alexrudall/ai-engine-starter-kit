class CreateMessageAndRun < SidekiqJob
  def perform(args)
    storyteller_id, assistant_thread_id, user_id, content = args.values_at("storyteller_id", "assistant_thread_id", "user_id", "content")

    user = User.find(user_id)

    assistant_thread = user.assistant_threads.find(assistant_thread_id)
    storyteller = user.storytellers.find(storyteller_id)

    storyteller.ai_engine_run(assistant_thread: assistant_thread, content: content)
  end
end
