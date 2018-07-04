class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]

  # GET /receipts
  # GET /receipts.json
  def index
	respond_to do |format|
		format.html { render :index }
		format.json { render :json => Receipt.all.order(purchase_date: :desc) }
	end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
	respond_to do |format|
		format.html { render :show }
		format.json { render :json => @receipt.to_json(methods: [:check_total,:subtotal]) }
	end
  end
  
  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)
    respond_to do |format|
      if @receipt.save
        format.json { render :json => @receipt }
      else
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.json { render :json => @receipt }
      else
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
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
