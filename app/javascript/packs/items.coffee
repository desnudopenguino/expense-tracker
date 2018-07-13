import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import ItemsView from 'views/items.vue'
import locale from 'element-ui/lib/locale/lang/en'
Vue.use(ElementUI, { locale })
items = new Vue({
	el: '[data-behavior="vue"]',
	components: {
		'items-view': ItemsView
	},
})
