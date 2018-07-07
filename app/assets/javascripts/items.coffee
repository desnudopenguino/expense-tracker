items = new Vue({
	el: '#items',
	data: {
		items:[],
		item: {},
		receipt: {},
	},
	mounted: ->
		this.fetchItems()
		this.fetchReceipt()
	methods: {
		resetFocus: ->
			document.getElementsByTagName("input")[0].focus()
		fetchItems: ->
			that = this;
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			$.ajax '/api/receipts/' + receipt_id + '/items',
				success: (res) ->
					that.items = []
					for k,v of res
						res[k].showdelete = false
					that.items.push.apply(that.items,[{}])
					that.items.push.apply(that.items,res)
				error: (res) ->
					that.errors = res.responseJSON.errors
		fetchReceipt: ->
			that = this;
			url_split = window.location.href.split('/')
			receipt_id = url_split[4];
			$.ajax '/api/receipts/' + receipt_id,
				success: (res) ->
					that.receipt = res;
				error: (res) ->
					that.errors = res.responseJSON.errors
		addItem: ->
			that = this;
			url_split = window.location.href.split('/')
			receipt_id = url_split[4]
			$.ajax '/api/receipts/' + receipt_id + '/items',
				method: 'POST',
				data: {
					item: that.item,
				},
				success: (res) ->
					that.errors = {}
					that.$notify({
						title: 'Item Added',
						type: 'success'
					});
					that.items.push(res)
					that.item = {}
					that.resetFocus()
					that.fetchReceipt()
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					});
					that.resetFocus()
		deleteItem: (receipt_id,item_id) ->
			that = this;
			$.ajax '/api/receipts/' + receipt_id + '/items/' + item_id,
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Item Removed',
						type: 'success'
					});
					that.fetchItems()
					that.fetchReceipt()
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					});
		updateItem: (item_obj) ->
			that = this;
			$.ajax '/api/receipts/' + item_obj.receipt_id + '/items/' + item_obj.id,
				method: 'PUT',
				data: {
					item: item_obj,
				},
				success: (res) ->
					that.$notify({
						title: 'Item Updated',
						type: 'success'
					});
					that.errors = {}
					that.fetchItems()
					that.fetchReceipt()
				error: (res) ->
					that.errors = res.responseJSON
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					});
	}
});
