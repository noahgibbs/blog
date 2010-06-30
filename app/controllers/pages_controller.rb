class PagesController < ApplicationController

  [:refactor1, :refactor2, :refactor3].each do |meth|
    define_method(meth) {}
  end
end
