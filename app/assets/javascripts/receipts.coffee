receipts = new Vue({
	el: '#receipts',
	data: {
		receipts:[],
		receipt: {},
	},
	mounted: ->
		this.fetchReceipts()
	methods: {
		fetchReceipts: ->
			that = this
			$.ajax '/api/receipts',
				success: (res) ->
					that.receipts = []
					for k,v of res
						res[k].showdelete = false
					that.receipts.push.apply(that.receipts,[{}])
					that.receipts.push.apply(that.receipts,res)
				error: (res) ->
					that.errors = res.responseJSON.errors
		addReceipt: ->
			that = this
			$.ajax '/api/receipts',
				method: 'POST',
				data: {
					receipt: that.receipt,
				},
				success: (res) ->
					that.errors = {}
					that.$notify({
						title: 'Receipt Added',
						type: 'success'
					})
					window.location.href = '/receipts/' + res.id
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					})
		deleteReceipt: (receipt_id) ->
			that = this
			$.ajax '/api/receipts/' + receipt_id,
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Receipt Removed',
						type: 'success'
					})
					that.fetchReceipts()
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					})
		
		updateReceipt: (receipt_obj) ->
			that = this
			$.ajax '/api/receipts/' + receipt_obj.id,
				method: 'PUT',
				data: {
					receipt: receipt_obj,
				},
				success: (res) ->
					that.$notify({
						title: 'Receipt Updated',
						type: 'success'
					})
					that.errors = {}
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					})
			
		viewReceipt: (receipt_id) ->
			that=this
			window.location.href = '/receipts/' + receipt_id
	}
})
