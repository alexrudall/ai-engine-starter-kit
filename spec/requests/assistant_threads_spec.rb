require "rails_helper"

RSpec.describe AssistantThreadsController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) { {} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new AssistantThread" do
        VCR.use_cassette("requests_assistant_threads_create") do
          expect {
            post assistant_threads_url, params: {assistant_thread: valid_attributes}
          }.to change(current_user.assistant_threads, :count).by(1)
        end

        expect(AI::Engine::AssistantThread.last.remote_id).to be_present
        expect(response).to redirect_to(assistant_thread_url(AI::Engine::AssistantThread.last))
      end
    end
  end
end
