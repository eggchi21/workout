class FoodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @food_groups = Food.where(ancestry: nil)
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
    @food_groups = Food.where(ancestry: nil)
  end

  def create
    @parent = Food.new(ancestry_params)
    if @parent.ancestry != ""
      @food_group = Food.find(@parent.ancestry)
      @food = @food_group.children.new(food_params)
      if @food.save
        flash[:notice] = '登録しました'
        redirect_to root_path
      else
        @food_groups = Food.where(ancestry: nil)
        render :new
      end
    else
      @food = Food.new(food_params)
      @food_groups = Food.where(ancestry: nil)
      render :new
    end
  end

  def search
    @foods = Food.where.not(ancestry: nil).where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def upload
    require 'google/cloud/vision'
    image = params[:image].path
    image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new
    image_text = (image_annotator_client.document_text_detection image: image).to_s
    if image_text.include?("たんぱく質")
      @protein = image_text[/たんぱく質(.{0,3}\d+\.?\d+)/][/\d+\.?\d+/].to_f
      @fat = image_text[/脂質(.{0,3}\d+\.?\d+)/][/\d+\.?\d+/].to_f
      @carbo = image_text[/炭水化物(.{0,3}\d+\.?\d+)/][/\d+\.?\d+/].to_f
      @data = { protein: @protein, fat: @fat, carbo: @carbo }
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def food_params
    params.require(:food).permit(
      :name,
      :protein,
      :fat,
      :carbo,
      :unit,
      :kcal,
      :gram
    )
  end

  def ancestry_params
    params.require(:food).permit(:ancestry)
  end
end
