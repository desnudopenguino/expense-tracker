import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import Receipts from 'views/receipts.vue'
import locale from 'element-ui/lib/locale/lang/en'
Vue.use(ElementUI, { locale })
receipts = new Vue({
	el: '[data-behavior="vue"]',
	components: { Receipts },
})
