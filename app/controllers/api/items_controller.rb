class Api::ItemsController < ApplicationController
	before_action :set_item, only: [:update, :destroy, :show]
	before_action :set_receipt
	before_action :receipt_items, only: [:index]

	# GET /items
	# GET /items.json
	def index
		render json: @items.to_json(methods: [:total_cost])
	end

	# GET /items/1
	# GET /items/1.json
	def show
		render json: @item.to_json(methods: [:total_cost])
	end
	# POST /items
	# POST /items.json
	def create
		@item = Item.new(item_params)
		@item.receipt = @receipt
		if @item.save
			render json: @item.to_json(methods: [:total_cost])
		else
			render json: @item.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /items/1
	# PATCH/PUT /items/1.json
	def update
		if @item.update(item_params)
			render json: @item.to_json(methods: [:total_cost])
		else
			render json: @item.errors, status: :unprocessable_entity
		end
	end

	# DELETE /items/1
	# DELETE /items/1.json
	def destroy
		@item.destroy
		head :no_content
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
		@items = Item.where(receipt_id: params[:receipt_id]).order("created_at DESC")
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def item_params
		params.require(:item).permit(:receipt_id, :name, :cost, :qty, :item_type)
	end
end
