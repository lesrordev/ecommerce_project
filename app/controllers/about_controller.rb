class AboutController < ApplicationController
  def index
    @page = Page.find_by(name: 'about')
  end
end
