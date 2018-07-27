import Vue from 'vue/dist/vue.esm'
import {
	Col,
	Row,
	Table,
	TableColumn,
	DatePicker,
	Input,
	ButtonGroup,
	Button,
	Popover,
	Loading,
	Notification,
} from 'element-ui'
import ReceiptVue from 'views/receipts.vue'
import ItemVue from 'views/items.vue'
import lang from 'element-ui/lib/locale/lang/en'
import locale from 'element-ui/lib/locale'
import TurbolinksAdapter from 'vue-turbolinks';

locale.use(lang)

Vue.use(Row)
Vue.use(Col)
Vue.use(Table)
Vue.use(TableColumn)
Vue.use(DatePicker)
Vue.use(Input)
Vue.use(ButtonGroup)
Vue.use(Button)
Vue.use(Popover)
Vue.use(Loading.directive)

Vue.prototype.$loading = Loading.service
Vue.prototype.$notify = Notification

Vue.use(TurbolinksAdapter)
Vue.component('receipt-vue', ReceiptVue)
Vue.component('item-vue', ItemVue)

document.addEventListener('turbolinks:load', ->
	element = document.getElementById 'vue-app'
	if element?
		receiptsapp = new Vue(
			el: element,
		)
)
