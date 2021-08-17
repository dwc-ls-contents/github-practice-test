class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ show edit update ]

  # GET /favorites or /favorites.json
  def index
    @favorites = Favorite.all
  end

  # # GET /favorites/1 or /favorites/1.json
  # def show
  # end

  # # GET /favorites/new
  # def new
  #   @favorite = Favorite.new
  # end

  # # GET /favorites/1/edit
  # def edit
  # end

  # POST /favorites or /favorites.json
  def create
    @post = Post.find(params[:post_id])
    @favorite = Favorite.new(post_id: @post.id,user_id: current_user.id)
    @favorite.save
    # redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: "Favorite was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find_by(post_id: @post.id)
    @favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:post_id)
    end
end
