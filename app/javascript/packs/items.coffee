import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import ItemsView from 'views/items.vue'
Vue.use(ElementUI)
items = new Vue({
	el: '[data-behavior="vue"]',
	components: {
		'items-view': ItemsView
	},
})
