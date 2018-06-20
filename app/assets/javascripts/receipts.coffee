Vue.component('receipt-row', {
	template: '#receipt-row',
	props: {
		receipt: Object
	}
})
receipts = new Vue({
	el: '#receipts',
	data: {
		receipts:[],
		receipt: {}
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
			$.ajax 'receipts.json',
				method: 'POST',
				data: {
					receipt: that.receipt,
				},
				success: (res) ->
					that.errors = {}
					that.receipts.push(res);
					that.$notify({
						title: 'Success',
						message: 'Receipt added.',
						type: 'success'
					});
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					});
		deleteReceipt: (receipt_id) ->
			console.log(receipt_id);
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
	}
});
