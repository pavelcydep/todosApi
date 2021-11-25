class CategoriesController < ApplicationController
    skip_before_action :verify_authenticity_token
    # GET /categories/
    def index
        categories = Category.left_outer_joins(:todos)
                            .select('categories.id, categories.title, todos.id AS todos')
                            .group('categories.id, categories.title')
        render json: categories, status: :ok
    end

   # DELETE categories/:id
 def destroy
    category = Category.find(params[:id])
    category.destroy
    render json: category, status: 204
end


  # GET /categories/:id
  def show
    category = find_category(params[:id])
    render json: category, status: :ok
    end


    def create
        category = Category.new(cat_params)
        if category.save
            category = find_category(category.id)
            render json: category, status: 201
        else
            # Что-то пошло не так
            render json: {errors: category.errors}, status: :unprocessable_entity
        end
    end
 # PUT /categories/:id
 def update
    category = Category.find(params[:id])
    if category.update(cat_params)
        render json: category, status: :ok
    else
        # Что-то пошло не так
        render json: {errors: category.errors}, status: :unprocessable_entity
    end
end

private

def cat_params
    params.require(:category).permit(:title)
end
def find_category id
    Category.left_outer_joins(:todos)
                        .select('categories.id, categories.title, COUNT(todos.id) AS todos_count')
                        .where(id: id)
                        .group('categories.id, categories.title')
end

end
