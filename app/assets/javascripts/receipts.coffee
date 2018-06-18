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
		receipt: {
			purchase_date: '',
			store: '',
			tax: 0.0,
			total: 0.0,
		}
	},
	mounted: ->
		that = this;
		$.ajax '/receipts.json',
			success: (res) -> that.receipts = res;
	methods: {
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
				error: (res) ->
					that.errors = res.responseJSON.errors
					
	}
});
