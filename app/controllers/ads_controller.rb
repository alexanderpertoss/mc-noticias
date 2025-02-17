class AdsController < ApplicationController
  before_action :set_ad, only: %i[ show edit update destroy ]
  layout "admin"

  def index
    @ads = Ad.order(created_at: :desc)
  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to @ad
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ad.update(ad_params)
      redirect_to @ad
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ad.destroy
    redirect_to ads_path
  end

  private
    def set_ad
      @ad = Ad.find(params[:id])
    end

    def ad_params
      params.expect(ad: [ :name, :main_image ])
    end
end
