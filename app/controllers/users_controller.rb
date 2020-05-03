class UsersController < ApplicationController
	before_action :correct_user, only: [:edit]

  def show
  	@user = User.find(params[:id])
  	@books = Book.all
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = current_user
    @books = Book.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render :edit
  	end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :introduction, :profile_image)
  end
  def correct_user
    user = User.find(params[:id])
    if user != current_user
           redirect_to user_path(current_user)
        end
    end

end
