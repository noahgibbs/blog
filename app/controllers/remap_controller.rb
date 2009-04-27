class RemapController < ApplicationController
  def index
    # This is a remapping from an old WordPress URL
    pagenum = params[:p].to_i
    redirect_to :controller => 'posts', :action => 'show', :id => pagenum + 8
  end
end
