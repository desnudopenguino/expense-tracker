<template>
	<el-row>
		<el-col :span="16" :offset="4">
			<h1>
			  <a href="/receipts" class="link">Receipts</a> &gt; {{ receipt.store }} on {{ receipt.purchase_date }}</h1>
			<el-row>
				<el-col :span="20">
					<el-table
						:data="receipt_wrapper"
						:row-class-name="tableRowClassName"
						style="width: 30%">
						<el-table-column
							prop="subtotal"
							label="Subtotal">
						</el-table-column>
						<el-table-column
							prop="tax"
							label="Tax">
						</el-table-column>
						<el-table-column
							prop="total"
							label="Total">
						</el-table-column>
					</el-table>
				</el-col>
			</el-row>
			<el-table
				:data="items"
				v-loading="loading"
				element-loading-text="loading..."
				stripe
				style="width: 100%">
				<el-table-column
					prop="name"
					label="Name"
					width="180">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Item Name" v-model="scope.row.name" @keyup.enter.native="updateItem(scope.row)">
						</el-input>
						<el-input v-else placeholder="Item Name" v-model="item.name" @keyup.enter.native="addItem">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="item_type"
					label="Type">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Item Type" v-model="scope.row.item_type" @keyup.enter.native="updateItem(scope.row)">
						</el-input>
						<el-input v-else placeholder="Item Type" v-model="item.item_type" @keyup.enter.native="addItem">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="cost"
					label="Cost"
					width="180">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Cost" v-model="scope.row.cost" @keyup.enter.native="updateItem(scope.row)">
						</el-input>
						<el-input v-else placeholder="Cost" v-model="item.cost" @keyup.enter.native="addItem">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="qty"
					label="Qty">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Qty" v-model="scope.row.qty" @keyup.enter.native="updateItem(scope.row)">
						</el-input>
						<el-input v-else placeholder="Qty." v-model="item.qty" @keyup.enter.native="addItem">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="total_cost"
					label="Total">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" :disabled="true" placeholder="Total" v-model="scope.row.total_cost">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column 
					fixed="right"
					label="Operations"
					width="220">
					<template slot-scope="props">
						<el-button-group v-if="props.row.id != undefined">
							<el-button @click="updateItem(props.row)" class="el-button el-button--primary el-icon-edit" type="button"></el-button>
							<el-popover
								placement="top"
								width="160"
								v-model="props.row.showdelete"
								>
								<p>Delete this item?</p>
								<div style="text-align: right; margin: 0;">
									<el-button size="mini" type="info" plain @click="props.row.showdelete = false">cancel</el-button>
									<el-button size="mini" type="danger" plain @click="deleteItem(props.row.receipt_id,props.row.id)">delete</el-button>
								</div>
								<el-button slot="reference" @click="props.row.showdelete = true" class="el-button el-button--danger el-icon-delete" type="button"></el-button>
							</el-popover>
						</el-button-group>
						<el-button-group v-else>
							<el-button @click="addItem" type="button" class="el-button el-button--success el-icon-plus"></el-button>
						</el-button-group>
					</template>
				</el-table-column>
			</el-table>
		</el-col>
	</el-row>
</template>
<script lang="coffee">
export default
	data: ->
		({
			items:[],
			item: { 'qty': 1},
			receipt: {},
			loading: true,
			receipt_wrapper: []
		})
	mounted: ->
		this.fetchItems()
		this.fetchReceipt()
	methods:
		resetFocus: ->
			document.getElementsByTagName("input")[0].focus()
		fetchItems: ->
			that = this
			url_split = window.location.href.split('/')
			receipt_id = url_split[4]
			$.ajax '/api/receipts/' + receipt_id + '/items',
				success: (res) ->
					that.items = []
					for k,v of res
						res[k].showdelete = false
						res[k].cost = res[k].cost.toFixed(2)
						res[k].total_cost = res[k].total_cost.toFixed(2)
					that.items = res
					that.items.unshift({})
					that.loading = false
				error: (res) ->
					that.errors = res.responseJSON.errors
		fetchReceipt:  (edit) ->
			that = this
			url_split = window.location.href.split('/')
			receipt_id = url_split[4]
			$.ajax '/api/receipts/' + receipt_id,
				success: (res) ->
					res.subtotal = res.subtotal.toFixed(2)
					res.total = res.total.toFixed(2)
					res.tax = res.tax.toFixed(2)
					that.receipt = res
					that.receipt_wrapper = [res]
					if edit == 1 and res.check_total
						that.$notify({
							title: 'Receipt Valid',
							type: 'success',
							position: 'bottom-left'
						})
				error: (res) ->
					that.errors = res.responseJSON.errors
		addItem: ->
			that = this
			url_split = window.location.href.split('/')
			receipt_id = url_split[4]
			$.ajax '/api/receipts/' + receipt_id + '/items',
				method: 'POST',
				data: {
					item: that.item,
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
				},
				success: (res) ->
					that.errors = {}
					that.$notify({
						title: 'Item Added',
						type: 'success',
						position: 'bottom-left'
					})
					that.items.splice(0,1)
					that.items.unshift(res)
					that.item = { 'qty': 1 }
					that.items.unshift(that.item)
					that.resetFocus()
					that.fetchReceipt(1)
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Please check the form fields',
						type: 'error',
						position: 'bottom-left'
					})
					that.resetFocus()
		deleteItem: (receipt_id,item_id) ->
			that = this
			$.ajax '/api/receipts/' + receipt_id + '/items/' + item_id,
				method: 'DELETE',
				data: {
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
				},
				success: (res) ->
					that.$notify({
						title: 'Item Removed',
						type: 'success',
						position: 'bottom-left'
					})
					that.fetchItems()
					that.fetchReceipt(1)
				error: (res) ->
					that.errors = res.responseJSON.errors
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error',
						position: 'bottom-left'
					})
		updateItem: (item_obj) ->
			that = this
			$.ajax '/api/receipts/' + item_obj.receipt_id + '/items/' + item_obj.id,
				method: 'PUT',
				data: {
					item: item_obj,
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
				},
				success: (res) ->
					that.$notify({
						title: 'Item Updated',
						type: 'success',
						position: 'bottom-left'
					})
					that.errors = {}
					that.fetchItems()
					that.fetchReceipt(1)
				error: (res) ->
					that.errors = res.responseJSON
					that.$notify({
						title: 'Error',
						message: 'Something went wrong',
						type: 'error',
						position: 'bottom-left'
					})
		tableRowClassName: ({row, rowIndex}) ->
			if row.check_total
				return "total-success"
			else
				return "total-failure"
</script>
