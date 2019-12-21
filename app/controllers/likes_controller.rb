class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = Like.where(user_id: current_user.id, plan_id: params[:id])
    Like.create(user_id: current_user.id, plan_id: params[:id]) if @like.empty?
    @likes = Like.where(plan_id: params[:id])
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @likes }
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, plan_id: params[:id])
    @like.destroy
    @likes = Like.where(plan_id: params[:id])
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @likes }
    end
  end
end
