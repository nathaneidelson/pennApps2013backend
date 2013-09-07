class FilesController < ApplicationController
  # get contents of the file in @ so they can be displayed in view

  before_filter :setFileNames

  def setFileNames

    @fileNames = ['strings', 'images', 'appearance', 'code']

  end

  def index

    @client = Client.find_by_token(session[:token])
    @assets = JsonAsset.find_all_by_client_id(@client.id)

  end

  def edit

    @asset = JsonAsset.find(params[:id])

    if !session[:token] || Client.find_by_token(session[:token]).json_assets.include?(@asset)
      params = nil
      redirect_to :controller => 'users', :action => 'new'
    end


  end

  def save

    @asset = JsonAsset.find(params[:id])
    @asset.content = params["textarea"]
    @asset.save()

    redirect_to :action => 'index'

  end

end
