class TodosController < ApplicationController
    skip_before_action :verify_authenticity_token
    # GET /categories/:category_id/todos
    def index
        todos = find_category(params[:category_id]).todos.select(:id, :text, :isCompleted)
        render json: todos, status: :ok
    end

    # GET /categories/:category_id/todos/:id
    def show
        todo = find_todo(params[:id])
        render json: todo, status: :ok
    end

    # POST /categories/:category_id/todos
    def create
        todo = find_category(params[:category_id]).todos.new(todo_params)
        if todo.save
            todo= find_todo(todo.id)
            render json: todo, status: 201
        else
            render json: {errors: todo.errors}, status: :unprocessable_entity
        end
    end

    # PUT /categories/:category_id/todos/:id
    def update
        todo = Todo.find(params[:id])
        if todo.update(todo_params)
            todo = find_todo(params[:id])
            render json: todo, status: :ok
        else
            render json: {errors: todo.errors}, status: :unprocessable_entity
        end
    end

    # DELETE /categories/:category_id/todos/:id
    def destroy
        todo = Todo.find(params[:id])
        todo.destroy
        render json: todo, status: 204
    end

    private

    def todo_params
        params.require(:todos).permit(:text, :isCompleted)
    end

    def find_category category_id
        Category.find(category_id)
    end
    def find_todo id
        Todo.select(:id, :text, :isCompleted).where(id: id)
    end
end

