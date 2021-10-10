class PicturesController < ApplicationController
  before_action :require_logged_in!

  def index
    @pictures = current_user.pictures.order(id: :desc)
  end

  def new
  end

  def create
    @picture = Picture.new(title: picture_params[:title], image: picture_params[:image], user_id: current_user.id)

    if @picture.save
      redirect_to pictures_path
    else
      add_flash_message :alert, 'タイトルを入力してください' if !params[:title]
      add_flash_message :alert, '画像ファイルを入力してください' if !params[:image]
      render :new
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :image)
  end
end
