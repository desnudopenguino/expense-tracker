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
			that = this;
			$.ajax '/receipts.json',
				success: (res) ->
					that.receipts = res;
				error: (res) ->
					that.errors = res.responseJSON.errors
		addReceipt: ->
			that = this;
			$.ajax '/receipts.json',
				method: 'POST',
				data: {
					receipt: that.receipt,
				},
				success: (res) ->
					that.errors = {}
					that.$notify({
						title: 'Success',
						message: 'Receipt added.',
						type: 'success'
					});
					that.receipts.push(res);
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					});
		deleteReceipt: (receipt_id) ->
			that = this;
			$.ajax '/receipts/' + receipt_id + '.json',
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Success',
						message: 'Receipt removed.',
						type: 'success'
					});
					that.fetchReceipts();
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					});
		
		updateReceipt: (receipt_obj) ->
			that = this;
			$.ajax '/receipts/' + receipt_obj.id + '.json',
				method: 'PUT',
				data: {
					receipt: receipt_obj,
				},
				success: (res) ->
					that.$notify({
						title: 'Success',
						message: 'Receipt updated.',
						type: 'success'
					});
					that.errors = {}
					that.receipt = res
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					});
			
		viewReceipt: (receipt_id) ->
			that=this;
			window.location.href = '/receipts/' + receipt_id + '/items'
	}
});
