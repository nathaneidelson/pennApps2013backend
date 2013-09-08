class FilesController < ApplicationController
  # get contents of the file in @ so they can be displayed in view
  require 'net/http'
  require 'uri'

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

    if !session[:token] || @asset.client != Client.find_by_token(session[:token])
      redirect_to :controller => 'clients', :action => 'new'
    end

  end


  def save

    @asset = JsonAsset.find(params[:id])
    @asset.content = params["textarea"]
    @asset.save()

    uri = URI.parse("http://pennapps-samplehook.herokuapp.com/users/notifyAll")

    Net::HTTP.get(uri)

    redirect_to :action => 'index'

  end

end
