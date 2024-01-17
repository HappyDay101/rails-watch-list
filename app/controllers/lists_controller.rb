class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to lists_path, notice: 'List was successfully destroyed.'
  end

  def update
    if @list.update(list_params)
      @list.reviews.create(comment: params[:list][:comment]) if params[:list][:comment].present?

      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, photos: [], reviews: [:comment])
  end
end
