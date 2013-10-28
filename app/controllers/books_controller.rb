class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /books
  # GET /books.json
  def index
    @books = Book.order("year DESC").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 10)
    @books_all = @books

    if params[:type]
      if params[:type] == 'collections'
        @books = @books.where('book_type NOT IN (?)', ['Monographie', 'Monographie in einer Reihe'])
      elsif params[:type] == 'monographs'
        @books = @books.where('book_type IN (?)', ['Monographie', 'Monographie in einer Reihe'])
      end
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new(:serial_id => params[:serial_id])
    article = @book.articles.build
    article.authorships.build
    book = @book.editorships.build

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])

    render :layout => "form_page"
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
end
