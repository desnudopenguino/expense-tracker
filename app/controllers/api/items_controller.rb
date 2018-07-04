class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :set_receipt
  before_action :receipt_items, only: [:index, :create, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
	respond_to do |format|
		format.html { render :index }
		format.json { render :json => @items.to_json(methods: [:total_cost]) }
	end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.receipt = @receipt

    respond_to do |format|
      if @item.save
        format.json { render :json => @item.to_json(methods: [:total_cost])  }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.json { render :json => @item.to_json(methods: [:total_cost])  }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
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
