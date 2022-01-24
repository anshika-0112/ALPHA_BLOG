class CategoriesController <  ApplicationController
    before_action :require_admin,only:[:new,:create]
    def new
        @category=Category.new
    end

    def index
        @categories=Category.paginate(page: params[:page],per_page: 5)
    end

    def show
        @category=Category.find(params[:id])
    end

    def create
        @category=Category.new(category_params)
        if @category.save
            flash[:notice]="Category created successfully"
            redirect_to category_path(@category)
        else
            render 'new',status: :unprocessable_entity
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert]="Only Admin can create Categories"
            redirect_to categories_path
        end
    end
end