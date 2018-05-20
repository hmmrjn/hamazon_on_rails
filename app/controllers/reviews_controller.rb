class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    if @user_logged_in
      @review = @user_logged_in.reviews.new(review_params)
    else
      @review = Review.new(review_params)
    end

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review.item, notice: 'レビューを投稿しました' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'レビューを更新しました' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @user_logged_in, notice: 'レビューを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:item_id, :score, :title, :content)
    end

      # prevent users from editing others users reviews
    def authenticate_user
      if @review.user_id != @user_logged_in.id
        flash[:notice] = "権限がありません"
        redirect_to(items_path)
      end
    end
end
