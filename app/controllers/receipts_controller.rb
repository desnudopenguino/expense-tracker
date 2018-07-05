class ReceiptsController < ApplicationController
  # GET /receipts
  # GET /receipts.json
  def index
	render :index
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
	render :show
  end
end
