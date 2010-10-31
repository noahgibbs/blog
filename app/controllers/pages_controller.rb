class PagesController < ApplicationController

  Actions = [:refactor1, :refactor2, :refactor3,
             :slide1, :slide2, :slide3, :slide4, :slide5,
             :slide6]

  caches_action *Actions

  Actions.each do |meth|
    define_method(meth) {}
  end
end
