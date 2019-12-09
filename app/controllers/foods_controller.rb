class FoodsController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  require 'google/cloud/vision'


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

    # image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new
    image_path = './erd.png'
    # @data = (image_annotator_client.document_text_detection image: gcs_image_uri).to_s

    # image  = vision.image image_path
    vision = Google::Cloud::Vision.new
    image  = vision.image image_path
    @data =[]
    image.logos.each do |logo|
      @data << logo.description
    end
    # gcs_image_uri = "https://i.gyazo.com/4cd8f66814874782fe4be092b5e7c446.png"
    # source = { gcs_image_uri: gcs_image_uri }
    # image = { source: source }
    # type = :FACE_DETECTION
    # features_element = { type: type }
    # features = [features_element]
    # requests_element = { image: image, features: features }
    # requests = [requests_element]
    # response = image_annotator_client.batch_annotate_images(requests)
    # image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new
    # gcs_image_uri = "gs://cloud-samples-data/vision/face_detection/celebrity_recognition/sergey.jpg"
    # @data = image_annotator_client.document_text_detection images:params[:file], image_context: {language_hints: [:ja, :en]}
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
