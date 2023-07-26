class BooksController < ApplicationController
  def new
      @books = Book.new
  end
   # 以下を追加
  def create
      @book = Book.new(book_params)

     if @book.save
       # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
     else
        @books = Book.all
      render :index #<= new から indexに変更
     end
  end

  def index
      @book = Book.new
     @books = Book.all

  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
     @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  def destroy
  book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
