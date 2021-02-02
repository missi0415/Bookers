class BooksController < ApplicationController
  def top #アプリケーショントップ画面
  end

  def index #投稿一覧画面　index.htmlに渡す
    @books = Book.all#インスタンス変数は自分で命名@viewへ渡せる
    @book = Book.new
  end



  def create
      # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)#このブックはコントローラ内でしかつかえない

    # ２. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:complete] = "Book was successfully created."
    # ３. 詳細画面へリダイレクトに変更
      redirect_to book_path(@book.id)#コントローラを通す
    else
      @books = Book.all
      render :index#コントローラを通さないでviewを出す
    end
  end


  def show #投稿詳細画面 Show ボタン
    @book = Book.find(params[:id])
    #       Bookというモデルから見つける
  end


  def edit #
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:update] = "Book was successfully updated."

    else
      render :edit
    end
  end



  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to books_path  # t投稿一覧画面へリダイレクト
    flash[:destroy] = "Book was successfully destroyed."
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)


    #params.require(:list).permit(:title, :body)
    #これがないとモデルを更新書き換えできない
    #ここを直そう
  end

end
