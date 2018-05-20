class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]
  before_action :require_login, only: [:new]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @review = Review.new
    @reviews = @item.reviews
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = @user_logged_in.items.new(item_params)

    respond_to do |format|
      if @item.save
        if image = params[:item][:image]
          image_name = "#{@item.id}.jpg"
          File.binwrite("public/item_images/#{image_name}", image.read)
          @item.update(image_name: image_name)
        else
          @item.update(image_name: "default_item.jpg")
        end
        format.html { redirect_to @item, notice: '商品を出品しました' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        if image = params[:item][:image]
          image_name = "#{@item.id}.jpg"
          File.binwrite("public/item_images/#{image_name}", image.read)
          @item.update(image_name: image_name)
        end
        format.html { redirect_to @item, notice: '商品情報を更新しました' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: '商品を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :description)
    end

    # prevent users from editing others users items
    def authenticate_user
      unless @user_logged_in && @item.user && @item.user.id == @user_logged_in.id
        flash[:notice] = "権限がありません"
        redirect_to(items_path)
      end
    end
end
