<template>
	<el-row :gutter="20">
		<el-col :span="16" :offset="4">
			<h1>Receipts</h1>
			<el-table
				:data="receipts"
				:default-sort = "{prop: 'purchase_date', order: 'ascending'}"
				v-loading="loading"
				element-loading-text="loading..."
				stripe
				style="width: 100%">
				<el-table-column
					prop="purchase_date"
					label="Purchase Date"
					sortable
					width="230">
					<template slot-scope="scope">
						<el-date-picker v-if="scope.row.id != undefined" type="datetime" value-format="yyyy-MM-d HH:mm:ss" placeholder="Purchase Date" v-model="scope.row.purchase_date" @keyup.enter.native="updateReceipt(scope.row)">
						</el-date-picker>
						<el-date-picker v-else type="datetime" value-format="yyyy-MM-d HH:mm:ss" placeholder="Purchase Date" v-model="receipt.purchase_date" @keyup.enter.native="addReceipt">
						</el-date-picker>
					</template>
				</el-table-column>
				<el-table-column
					prop="store"
					label="Store"
					width="180">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Store" v-model="scope.row.store" @keyup.enter.native="updateReceipt(scope.row)">
						</el-input>
						<el-input v-else placeholder="Store" v-model="receipt.store" @keyup.enter.native="addReceipt">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="tax"
					label="Tax">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Tax" v-model="scope.row.tax" @keyup.enter.native="updateReceipt(scope.row)">
						</el-input>
						<el-input v-else placeholder="Tax" v-model="receipt.tax" @keyup.enter.native="addReceipt">
						</el-input>
					</template>
				</el-table-column>
				<el-table-column
					prop="total"
					label="Total">
					<template slot-scope="scope">
						<el-input v-if="scope.row.id != undefined" placeholder="Total" v-model="scope.row.total" @keyup.enter.native="updateReceipt(scope.row)">
						</el-input>
						<el-input v-else placeholder="Total" v-model="receipt.total" @keyup.enter.native="addReceipt">
						</el-input>
					</template>
				</el-table-column>

				<el-table-column
					fixed="right"
					label="Operations"
					width="220">
					<template slot-scope="props">
						<el-button-group v-if="props.row.id != undefined">
							<a :href="props.row.path" class="el-button el-button--info el-icon-tickets" type="button"></a>
							<el-button @click="updateReceipt(props.row)" class="el-button el-button--primary el-icon-edit" type="button"></el-button>
							<el-popover
								placement="top"
								width="160"
								v-model="props.row.showdelete"
								>
								<p>Delete this receipt?</p>
								<div style="text-align: right; margin: 0;">
									<el-button size="mini" type="info" plain @click="props.row.showdelete = false">cancel</el-button>
									<el-button size="mini" type="danger" plain @click="deleteReceipt(props.row.id)">delete</el-button>
								</div>
								<el-button slot="reference" @click="props.row.showdelete = true" class="el-button el-button--danger el-icon-delete" type="button"></el-button>
							</el-popover>
						</el-button-group>
						<el-button-group v-else>

							<el-button @click="addReceipt" type="button" class="el-button el-button--success el-icon-plus"></el-button>
						</el-button-group>
					</template>
				</el-table-column>
			</el-table>
		</el-col>
	</el-row>
</template>
<script lang="coffee">
export default {
	data: ->
		({
			receipts:[],
			receipt: {},
			loading: true,
		})
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
						res[k].path = "/receipts/"+res[k].id
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
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
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
				data: {
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
				},
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
					authenticity_token: document.getElementsByName("csrf-token")[0].content,
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
}
</script>
