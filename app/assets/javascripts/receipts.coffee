receipts = new Vue({
	el: '#receipts',
	data: {
		receipts:[],
		receipt: {},
		loading: true,
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
					that.loading = false
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
						type: 'success',
						position: 'bottom-left'
					})
					window.location.href = '/receipts/' + res.id
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error',
						position: 'bottom-left'
					})
		deleteReceipt: (receipt_id) ->
			that = this
			$.ajax '/api/receipts/' + receipt_id,
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Receipt Removed',
						type: 'success',
						position: 'bottom-left'
					})
					that.fetchReceipts()
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error',
						position: 'bottom-left'
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
						type: 'success',
						position: 'bottom-left'
					})
					that.errors = {}
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error',
						position: 'bottom-left'
					})
			
		viewReceipt: (receipt_id) ->
			that=this
			window.location.href = '/receipts/' + receipt_id
	}
})
