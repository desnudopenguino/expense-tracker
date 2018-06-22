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
			url_split = window.location.href.split('/');
			receipt_id = url_split[4];
			that = this;
			$.ajax '/receipts/' + receipt_id + '/items.json',
				success: (res) ->
					that.items = res;
				error: (res) ->
					that.errors = res.responseJSON.errors
		addItem: ->
			that = this;
			$.ajax 'items.json',
				method: 'POST',
				data: {
					item: that.item,
				},
				success: (res) ->
					that.errors = {}
					that.$notify({
						title: 'Success',
						message: 'Item added.',
						type: 'success'
					});
					that.items.push(res);
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error'
					});
		deleteItem: (receipt_id,item_id) ->
			console.log(item_id);
			that = this;
			$.ajax '/receipts/' + receipt_id + '/items/' + item_id + '.json',
				method: 'DELETE',
				success: (res) ->
					that.$notify({
						title: 'Success',
						message: 'Item removed.',
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
		viewItem: (item_id) ->
			that=this;
			window.location.href = '/items/' + item_id + '/items'
	}
});
