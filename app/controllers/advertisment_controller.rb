class AdvertismentController < ApplicationController
  def index
    @ad = Advertisment.all
  end

  def show
    @ad = Advertisment.find(params[:id])
  end

  def new
    @ad = Advertisment.new
  end

  def create
    @ad = Advertisment.new
    @ad.title = params[:advertisment][:title]
    @ad.body = params[:advertisment][:body]
    if @ad.save
      flash[:notice] = "Advertisment was saved."
      redirect_to @ad
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end
end
