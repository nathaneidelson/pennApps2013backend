class ClientsController < ApplicationController

  respond_to :json
  require 'json'

  def getBatchedJSONData

    @client = Client.where(:token => params[:token]).first

    response = Hash.new

    response['appearance'] = JSON.parse(@client.json_assets.where(:name => 'appearance').first.content)

    response['strings'] = JSON.parse(@client.json_assets.where(:name => 'strings').first.content)

    response['images'] = JSON.parse(@client.json_assets.where(:name => 'images').first.content)

    response['code'] = @client.json_assets.where(:name => 'code').first.content

    p response

    respond_with(response, :location => 'nil')

  end


  def new

    if session[:token]
      @token = session[:token]
    end

  end


  def create

    @client = Client.find_by_token(params[:token])

    if (!@client.nil?)

      session[:token] = params[:token]
      redirect_to :controller => 'files', :action => 'index'

    else

      @client = Client.new
      @client.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Client.where(token: random_token).exists?
      end

      @client.save()

      session[:token] = @client.token

      JsonAsset.create(:client_id => @client.id, :name => 'appearance')
      JsonAsset.create(:client_id => @client.id, :name => 'strings')
      JsonAsset.create(:client_id => @client.id, :name => 'images')
      JsonAsset.create(:client_id => @client.id, :name => 'code')

      redirect_to :controller => 'clients', :action => 'new', :token => @client.token

    end

  end

end
