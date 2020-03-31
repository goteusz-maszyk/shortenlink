class PagesController < ApplicationController
  def home
    if user_signed_in?
      @my_links = Link.where(user_id: current_user.id).all
    end
    @link = Link.new
  end
end