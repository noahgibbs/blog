class PagesController < ApplicationController

  Actions = [:refactor1, :refactor2, :refactor3]

  caches_action *Actions

  Actions.each do |meth|
    define_method(meth) {}
  end
end
