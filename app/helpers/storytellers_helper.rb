module StorytellersHelper
  def model_options(storyteller:)
    options_for_select(AI::Engine::Assistant::MODEL_OPTIONS, selected: storyteller.model)
  end
end
