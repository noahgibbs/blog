class RemapController < ApplicationController
  def index
    # This is a remapping from an old WordPress URL
    pagenum = params[:p].to_i

    # This remaps old page numbers to new ones
    remap_pages = {
       3 => 14,
       4 => 15,
       7 => 16,
       6 => 17,
       8 => 18,
      10 => 19,
      12 => 20,
      13 => 21,
      14 => 22,
      15 => 23,
      17 => 24,
      18 => 25,
      19 => 26,
      20 => 27,
      22 => 28,
      23 => 29,
      24 => 30,
      25 => 31,
      27 => 32,
      28 => 33,
      29 => 34,
      30 => 35,
      31 => 36,
      32 => 37,
      33 => 38,
      34 => 39,
      35 => 40,
      36 => 41,
      37 => 42
    };

    if(params[:p])
      new_id = remap_pages[pagenum]
      redirect_to :controller => 'posts', :action => 'show', :id => new_id
    else
      redirect_to :controller => 'posts', :action => 'index'
    end
  end
end
