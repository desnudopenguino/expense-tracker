class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_receipt
  before_action :receipt_items, only: [:index, :create, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
	respond_to do |format|
		format.html { render :index }
		format.json { render :json => @items }
	end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new(:receipt => @receipt)
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.receipt = @receipt

    respond_to do |format|
      if @item.save
        # format.html { redirect_to receipt_items_path(@receipt), notice: 'Item was successfully created.' }
        format.json { render :json => @item }
      else
        # format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to receipt_items_path @receipt, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to receipt_items_url @receipt, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_receipt
      @receipt = Receipt.find params[:receipt_id]
    end 

    def receipt_items
      @items = Item.where(receipt_id: params[:receipt_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:receipt_id, :name, :cost, :qty, :item_type)
    end
end
