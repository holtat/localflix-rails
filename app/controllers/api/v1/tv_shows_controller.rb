class API::V1::TvShowsController < ApplicationController
  before_action :authenticate
  before_action :set_tv_show_from_params, only: :show
  after_action :verify_authorized, only: :show
  after_action :verify_policy_scoped, only: :index

  def index
    render json: policy_scope(TvShow), status: :ok
  end

  def show
    authorize @tv_show
    render json: @tv_show, stats: :ok
  end

  private

  def set_tv_show_from_params
    @tv_show = TvShow.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :ok
  end
end
