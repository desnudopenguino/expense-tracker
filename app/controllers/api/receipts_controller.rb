class Api::ReceiptsController < ApplicationController
	before_action :set_receipt, only: [:show, :update, :destroy]

	# GET /receipts
	# GET /receipts.json
	def index
		render :json => Receipt.all.order(purchase_date: :desc)
	end

	# GET /receipts/1
	# GET /receipts/1.json
	def show
		render :json => @receipt.to_json(methods: [:check_total,:subtotal])
	end

	# POST /receipts
	# POST /receipts.json
	def create
		@receipt = Receipt.new(receipt_params)
		if @receipt.save
			render :json => @receipt
		else
			render json: @receipt.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /receipts/1
	# PATCH/PUT /receipts/1.json
	def update
		if @receipt.update(receipt_params)
			render :json => @receipt
		else
			render json: @receipt.errors, status: :unprocessable_entity
		end
	end

	# DELETE /receipts/1
	# DELETE /receipts/1.json
	def destroy
		@receipt.destroy
		head :no_content
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_receipt
		@receipt = Receipt.find_by(id: params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def receipt_params
		params.require(:receipt).permit(:purchase_date, :store, :tax, :total, 'purchase_date(1i)', 'purchase_date(2i)', 'purchase_date(1i)')
	end
end
