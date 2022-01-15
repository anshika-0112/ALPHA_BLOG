class ArticlesController < ApplicationController
    def show
        @article=Article.find(params[:id])
    end

    def index
        @articles=Article.all
    end

    def new
        @article=Article.new
    end

    def create
        @article=Article.new(params.require(:article).permit(:title,:descrition,:author))
        respond_to do |format|
            if @article.save
                flash[:notice] = "Article Created Successfully"
                redirect_to @article  #shorthand:- redirect_to @article
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end
end