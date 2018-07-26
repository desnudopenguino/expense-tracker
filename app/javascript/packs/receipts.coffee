import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import ReceiptVue from 'views/receipts.vue'
import ItemVue from 'views/items.vue'
import locale from 'element-ui/lib/locale/lang/en'
import TurbolinksAdapter from 'vue-turbolinks';
Vue.use(ElementUI, { locale })
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
