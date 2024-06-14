FactoryBot.define do
  factory :user do
    avatar_url { Faker::Avatar.image }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :storyteller do
    name { Faker::Company.buzzword }
    model { AI::Engine::Assistant::MODEL_OPTIONS.sample }
    instructions { Faker::Company.bs }
    description { Faker::Company.bs }
    max_prompt_tokens { AI::Engine::Assistant::MIN_PROMPT_TOKENS }
    max_completion_tokens { AI::Engine::Assistant::MIN_COMPLETION_TOKENS }
  end

  factory :assistant_thread, class: AI::Engine::AssistantThread do
    remote_id { "#{AI::Engine::AssistantThread.remote_id_prefix}#{Faker::Alphanumeric.alphanumeric(number: 24)}" }
    threadable { create(:user) }
  end

  factory :assistant, class: AI::Engine::Assistant do
    remote_id { "#{AI::Engine::Assistant.remote_id_prefix}#{Faker::Alphanumeric.alphanumeric(number: 24)}" }
  end

  factory :message, class: AI::Engine::Message do
    assistant_thread { create(:assistant_thread) }
    role { 1 }
    content { "Hi" }
  end
end
