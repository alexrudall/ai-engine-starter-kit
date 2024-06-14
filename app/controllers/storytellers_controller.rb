class StorytellersController < ApplicationController
  before_action :set_storyteller, only: %i[show edit update destroy]

  # GET /storytellers or /storytellers.json
  def index
    @storytellers = Storyteller.all.order(created_at: :desc)
  end

  # GET /storytellers/1 or /storytellers/1.json
  def show
  end

  # GET /storytellers/new
  def new
    @storyteller = Storyteller.new
  end

  # GET /storytellers/1/edit
  def edit
  end

  # POST /storytellers or /storytellers.json
  def create
    @storyteller = current_user.storytellers.new(storyteller_params)

    respond_to do |format|
      if @storyteller.save
        format.html { redirect_to storyteller_url(@storyteller), notice: "Storyteller was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storytellers/1 or /storytellers/1.json
  def update
    respond_to do |format|
      if @storyteller.update(storyteller_params)
        format.html { redirect_to storyteller_url(@storyteller), notice: "Storyteller was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storytellers/1 or /storytellers/1.json
  def destroy
    @storyteller.destroy!

    respond_to do |format|
      format.html { redirect_to storytellers_url, notice: "Storyteller was successfully deleted." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_storyteller
    @storyteller = current_user.storytellers.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def storyteller_params
    params.require(:storyteller).permit(:name, :model, :description, :instructions, :max_prompt_tokens, :max_completion_tokens)
  end
end
