class FoodsController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]


  def index
    @food_groups = Food.where(ancestry: nil)
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end


  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to root_path
    else
      render :new
    end
  end


  def search
    @foods = Food.where.not(ancestry: nil).where('name LIKE(?)',"#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def upload
    require 'google/cloud/vision'


  # image = "erd.png"
  image = params[:file]

  image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new
  @data = (image_annotator_client.document_text_detection image: image ).to_s

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def food_params
    params.require(:food).permit(:name,images: [])
  end
end
