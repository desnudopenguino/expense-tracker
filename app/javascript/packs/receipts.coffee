import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import ReceiptsView from 'views/receipts.vue'
Vue.use(ElementUI)
receipts = new Vue({
	el: '[data-behavior="vue"]',
	components: {
		'receipts-view': ReceiptsView
	},
})
