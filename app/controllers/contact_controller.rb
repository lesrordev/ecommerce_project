class ContactController < ApplicationController
  def index
    @page = Page.find_by(name: 'contact')
  end
end
