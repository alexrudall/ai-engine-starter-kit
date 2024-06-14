require "rails_helper"

RSpec.describe MessagesController, type: :request do
  let(:current_user) { create(:user) }
  let(:storyteller) do
    current_user.storytellers << build(:storyteller)
    current_user.storytellers.last
  end
  let(:valid_attributes) { {storyteller_id: storyteller.id, content: "Hi there"} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      context "with an assistant" do
        it "creates a new Message" do
          # Creates an assistant, thread, run and request and response messages on the OpenAI API.
          VCR.use_cassette("requests_messages_create_and_run") do
            assistant_thread = current_user.assistant_threads.create

            expect {
              post assistant_thread_messages_url(assistant_thread_id: assistant_thread.id), as: :turbo_stream, params: {message: valid_attributes}
            }.to change(current_user.assistant_threads.last.messages, :count).by(2)
          end

          assistant_thread = current_user.assistant_threads.last
          expect(assistant_thread.messages.count).to eq(2)
          response = assistant_thread.messages.last
          expect(response.remote_id).to be_present
          expect(response.run).to be_present
          expect(response.run.prompt_token_usage).to be_present
          expect(response.run.completion_token_usage).to be_present
        end
      end
    end
  end
end
