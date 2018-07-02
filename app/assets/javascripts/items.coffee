items = new Vue({
	el: '#items',
	data: {
		items:[],
		item: {},
		receipt: {}
	},
	mounted: ->
		this.fetchItems()
		this.fetchReceipt()
	methods: {
		resetFocus: ->
			input = document.getElementsByTagName("input")[0]
			input.focus()	
		fetchItems: ->
			that = this;
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			$.ajax '/receipts/' + receipt_id + '/items.json',
				success: (res) ->
					that.items = []
					that.items.push.apply(that.items,[{}]);
					that.items.push.apply(that.items,res);
				error: (res) ->
					that.errors = res.responseJSON.errors
		fetchReceipt: ->
			that = this;
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			$.ajax '/receipts/' + receipt_id + '.json',
				success: (res) ->
					that.receipt = res;
				error: (res) ->
					that.errors = res.responseJSON.errors
		addItem: ->
			that = this;
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			$.ajax '/receipts/' + receipt_id + '/items.json',
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
					that.items.push(res);
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
			$.ajax '/receipts/' + receipt_id + '/items/' + item_id + '.json',
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Item Removed',
						type: 'success'
					});
					that.fetchItems();
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
			$.ajax '/receipts/' + item_obj.receipt_id + '/items/' + item_obj.id + '.json',
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
