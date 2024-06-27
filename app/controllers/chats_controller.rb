class ChatsController < ApplicationController
  before_action :set_chat, only: %i[show edit update destroy]

  # GET /chats or /chats.json
  def index
    @chats = current_user.chats.all.order(created_at: :desc)
  end

  # GET /chats/1 or /chats/1.json
  def show
    @selected_model = @chat.messages.order(:created_at).last&.model
  end

  # GET /chats/new
  def new
    @chat = current_user.chats.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats or /chats.json
  def create
    @chat = current_user.chats.new

    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy!

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = current_user.chats.find(params[:id])
  end
end
