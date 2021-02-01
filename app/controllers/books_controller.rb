class BooksController < ApplicationController
  def top #アプリケーショントップ画面
  end

  def index #投稿一覧画面　index.htmlに渡す
    @books = Book.all#インスタンス変数は自分で命名@viewへ渡せる
    @book = Book.new
  end

  def create
      # １. データを新規登録するためのインスタンス作成
    book = Book.new(book_params)#このブックはコントローラ内でしかつかえない
    # ２. データをデータベースに保存するためのsaveメソッド実行
    book.save
    # ３. トップ画面へリダイレクトから詳細画面へリダイレクトに変更
    redirect_to books_path(book.id)
  end


  def show #投稿詳細画面 Show ボタン
    @book = Book.find(params[:id])
    #       Bookというモデルから見つける
  end


  def edit #
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end



  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:Title, :Body)

    #params.require(:list).permit(:title, :body)
    #これがないとモデルを更新書き換えできない
    #ここを直そう
  end

end
