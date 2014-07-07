initScope_module = angular.module 'classy-initScope', ['classy-core']

initScope_module.classy.plugin.controller
	name: 'initScope'

	options:
		enabled: true
		
	init: (klass, deps, module) ->
		# Adds controller functions (unless they have a `_` prefix) to the `$scope`
		if @options.enabled and klass.constructor::initScope
		    for key, value of klass.constructor::initScope.call klass
		        deps.$scope[key] = value
		return