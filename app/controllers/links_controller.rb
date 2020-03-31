class LinksController < ApplicationController
  def destroy
    link = Link.find_by_id(params[:id])
    link.destroy
    redirect_to root_url
  end
  def run
    if Link.find_by_shlink(params[:token])
      link = Link.find_by_shlink(params[:token])
      redirect_to link.org_link
    else
      render json: 'not found'
    end
  end
  def show
    if Link.find_by_shlink(params[:token])
      @link = Link.find_by_shlink(params[:token])
      render '/pages/show_link_data'
    else
      render json: 'not found'
    end
  end
  def create
    link = Link.new(org_link: params[:link][:org_link], shlink: Devise.friendly_token(6), user_id: current_user.id )
    if link.save
      redirect_to link_info_path(token: link.shlink), flash: { info: "Wygenerowano" }
    end
  end
end