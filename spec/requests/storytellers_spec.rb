require "rails_helper"

RSpec.describe StorytellersController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) do
    build(:storyteller).attributes.except("id", "created_at", "updated_at", "remote_id")
  end
  let(:storyteller) do
    VCR.use_cassette("requests_storytellers_create") do
      expect {
        post storytellers_url, params: {storyteller: valid_attributes}
      }.to change(Storyteller, :count).by(1)
    end
    Storyteller.last
  end

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Storyteller" do
        expect(storyteller.name).to eq(valid_attributes["name"])
        expect(storyteller.user).to eq(current_user)
        expect(storyteller.assistant.remote_id).to be_present

        expect(response).to redirect_to(storyteller_url(storyteller))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {instructions: "Design a big hat"} }

      it "updates the requested storyteller, locally AND remotely" do
        VCR.use_cassette("requests_storytellers_update") do
          patch storyteller_url(storyteller), params: {storyteller: new_attributes}
        end

        VCR.use_cassette("requests_storytellers_retrieve") do
          response = AI::Engine::OpenAI::Assistants::Retrieve.call(remote_id: storyteller.assistant.remote_id)
          expect(response["instructions"]).to eq(new_attributes[:instructions])
        end

        expect(storyteller.reload.instructions).to eq(new_attributes[:instructions])
        expect(response).to redirect_to(storyteller_url(storyteller))
      end
    end
  end
end
