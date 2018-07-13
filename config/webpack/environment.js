const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

const babelLoader = environment.loaders.get('babel')

environment.loaders.insert('coffee', {
	test: /\.coffee(\.erb)?$/,
	use: babelLoader.use.concat(['coffee-loader'])
})

environment.loaders.append('vue', vue)
module.exports = environment
