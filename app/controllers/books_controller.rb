class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @book_new = Book.new
    @book_comment = BookComment.new
    @book = Book.find(params[:id])
    @user = @book.user
    view = current_user.view_counts.find_by(book_id: @book.id)
    if view.nil?
      view = current_user.view_counts.new(book_id: @book.id)
      view.save
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @book = Book.new
    @books = Book.includes(:favorites).
    sort {|a,b|
    b.favorites.where(created_at: from...to).size <=>
    a.favorites.where(created_at: from...to).size
    }
    @today = Book.today_books.count
    @yesterday_books = Book.yesterday_books.count
    @books_2day = Book.books_2day.count
    @books_3day = Book.books_3day.count
    @books_4day = Book.books_4day.count
    @books_5day = Book.books_5day.count
    @books_6day = Book.books_6day.count
    @books_7day = Book.books_7day.count

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def books_sort
    @book = Book.new
    @books_sort = Book.all.order(params[:sort])
    @today = Book.today_books.count
    @yesterday_books = Book.yesterday_books.count
    @books_2day = Book.books_2day.count
    @books_3day = Book.books_3day.count
    @books_4day = Book.books_4day.count
    @books_5day = Book.books_5day.count
    @books_6day = Book.books_6day.count
    @books_7day = Book.books_7day.count
  end

  

  private

  def book_params
    params.require(:book).permit(:title,:body,:rate)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
