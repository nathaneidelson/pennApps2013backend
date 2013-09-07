class ClientsController < ApplicationController

  def index

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