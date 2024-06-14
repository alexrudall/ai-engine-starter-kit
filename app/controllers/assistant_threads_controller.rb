class AssistantThreadsController < ApplicationController
  before_action :set_assistant_thread, only: %i[show edit update destroy]

  # GET /assistant_threads or /assistant_threads.json
  def index
    @assistant_threads = current_user.assistant_threads.all.order(created_at: :desc)
  end

  # GET /assistant_threads/1 or /assistant_threads/1.json
  def show
    @selected_storyteller_id = @assistant_thread.messages.order(:created_at).last&.run&.assistant&.assistable_id
  end

  # GET /assistant_threads/new
  def new
    @assistant_thread = current_user.assistant_threads.new
  end

  # GET /assistant_threads/1/edit
  def edit
  end

  # POST /assistant_threads or /assistant_threads.json
  def create
    @assistant_thread = current_user.assistant_threads.new

    respond_to do |format|
      if @assistant_thread.save
        format.html { redirect_to assistant_thread_url(@assistant_thread), notice: "Thread was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assistant_threads/1 or /assistant_threads/1.json
  def update
    respond_to do |format|
      if @assistant_thread.save
        format.html { redirect_to assistant_thread_url(@assistant_thread), notice: "Thread was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistant_threads/1 or /assistant_threads/1.json
  def destroy
    @assistant_thread.destroy!

    respond_to do |format|
      format.html { redirect_to assistant_threads_url, notice: "Thread was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assistant_thread
    @assistant_thread = current_user.assistant_threads.find(params[:id])
  end
end
