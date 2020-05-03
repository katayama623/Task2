class BooksController < ApplicationController
  before_action :correct_book, only: [:edit]

  def show
  	@book = Book.new
    @book = Book.find(params[:id])
  end

  def index
  	@books = Book.all
    @book = Book.new #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		render :index
  	end
  end

  def new
    @book = Book.new(book_params)
    @books = Book.all
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
    @book.user_id = current_user.id
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render :index
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_book
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end

end
