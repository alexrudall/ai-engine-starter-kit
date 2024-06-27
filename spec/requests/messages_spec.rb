require "rails_helper"

RSpec.describe MessagesController, type: :request do
  let(:current_user) { create(:user) }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      context "with a chat" do
        let(:chat) { current_user.chats.create }
        let(:model) { AI::Engine::MODEL_OPTIONS.sample }
        let(:valid_attributes) { {chat_id: chat.id, content: "Hi there", model: model} }

        it "creates a new Message" do
          # Sends the message history off to OpenAI and gets the response.
          VCR.use_cassette("requests_chat_messages_create_and_run") do
            expect {
              post messages_url, as: :turbo_stream, params: {message: valid_attributes}
            }.to change(chat.messages, :count).by(2)
          end

          expect(chat.messages.count).to eq(2)
          response = chat.messages.last
          expect(response.content).to be_present
          expect(response.model).to eq(model)
          expect(response.remote_id).to eq(nil)
        end
      end

      context "with an assistant" do
        let(:storyteller) do
          current_user.storytellers << build(:storyteller)
          current_user.storytellers.last
        end
        let(:assistant_thread) { current_user.assistant_threads.create }
        let(:valid_attributes) { {assistant_thread_id: assistant_thread.id, storyteller_id: storyteller.id, content: "Hi there"} }

        it "creates a new Message" do
          # Creates an assistant, thread, run and request and response messages on the OpenAI API.
          VCR.use_cassette("requests_assistant_messages_create_and_run") do
            expect {
              post messages_url, as: :turbo_stream, params: {message: valid_attributes}
            }.to change(assistant_thread.messages, :count).by(2)
          end

          expect(assistant_thread.messages.count).to eq(2)
          response = assistant_thread.messages.last
          expect(response.remote_id).to be_present
          expect(response.run).to be_present
          expect(response.model).to eq(storyteller.model)
          expect(response.prompt_token_usage).to be_present
          expect(response.completion_token_usage).to be_present
        end
      end
    end
  end
end
