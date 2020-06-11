require 'bcrypt'
include BCrypt

class LinksController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to root_url
  end

  def run
    if Link.find_by_shlink(params[:token])
      @link = Link.find_by_shlink(params[:token])
      @link.encrypted_password.blank?() ? redirect_to(@link.org_link) : render(:check_password)
    else
      render json: 'not found'
    end
  end

  def show
    if Link.find_by_shlink(params[:id])
      @link = Link.find_by_shlink(params[:id])
    else
      render json: 'not found'
    end
  end

  def create
    authenticate_user!
    link = Link.new(title: params[:link][:title], org_link: params[:link][:org_link], shlink: Devise.friendly_token(6), user_id: current_user.id)
    if !(params[:link][:password] == "")
      link.encrypted_password = ::Password.create(params[:link][:password])
    end
    if link.save
      redirect_to link_url(id: link.shlink), flash: { info: "Wygenerowano" }
    end
  end

  def edit
    @link = Link.find_by_shlink(params[:id])
    if !(current_user == @link.user) || !(current_user.pro?)
      render file: Rails.root + 'public/404.html', status: 404, layout: false
      return
    end
    if @link
      @link = Link.find_by_shlink(params[:id])
    else
      render json: 'not found'
    end
  end

  def update
    @link = Link.find_by_shlink(params[:id])
    @link ||= Link.new
    if !(current_user == @link.user) || !(current_user.pro?)
      render file: Rails.root + 'public/404.html', status: 404, layout: false
      return
    end
    if !(params[:link][:password] == "")
      @link.encrypted_password = ::Password.create(params[:link][:password])
    else
      @link.encrypted_password = nil
    end
    @link.title = params[:link][:title]
    if @link.save
      redirect_to link_url(id: @link.shlink), notice: "zapisano"
    else
      render json: 'not found'
    end
  end

  def password_check
    @link = Link.find_by_shlink params[:id]
    if ::Password.new(@link.encrypted_password) == params[:password_check]
      redirect_to @link.org_link
    else
      render :check_password
    end
  end

  def destroy
    authenticate_user!
    link = Link.find_by_shlink(params[:id])
    link.destroy
    redirect_to root_url
  rescue ActiveRecord::InvalidForeignKey
    redirect_to root_url, flash: { alert: "Nie można usunąć" }
  end
end
