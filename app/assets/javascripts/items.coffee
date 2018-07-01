items = new Vue({
	el: '#items',
	data: {
		items:[],
		item: {}
	},
	mounted: ->
		this.fetchItems()
	methods: {
		fetchItems: ->
			that = this;
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			$.ajax '/receipts/' + receipt_id + '/items.json',
				success: (res) ->
					that.items = res;
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
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					});
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
				error: (res) ->
					that.errors = res.responseJSON
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error'
					});
	}
});
