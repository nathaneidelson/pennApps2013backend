class FilesController < ApplicationController
  # get contents of the file in @ so they can be displayed in view

  before_filter :setFileNames

  def setFileNames
    @fileNames = ['strings', 'images', 'appearance', 'code']
  end

  def index

  end

  def edit
    @params = params
    @fileContents = File.read(Rails.root.join('lib', 'assets', @fileNames[@params[:id].to_i]))

  end

  def save

    p params["textarea"]

    File.delete(Rails.root.join('lib', 'assets', @fileNames[params[:id].to_i]))


    File.open(Rails.root.join('lib', 'assets', @fileNames[params[:id].to_i]), "w") { |file|
      file.write params["textarea"]
    }

    redirect_to :action => 'index'


  end
  #
  #def show
  #
  #  redirect_to :action => 'index'
  #
  #end
  #
  #def update
  #  # save file with versioning
  #
  #  redirect_to :action => 'index'
  #end




end
