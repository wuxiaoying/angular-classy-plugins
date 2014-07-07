mixins_module = angular.module 'classy-mixins', ['classy-core']

###
    TODO: Note that this does NOT get the mixin class dependencies as of now.
    Should probably do something similar to extends?
###

mixins_module.classy.plugin.controller
    name: 'mixins'
    
    localInject: ['$controller']
    
    options:
        enabled: true
        ignore: ['constructor', 'init', 'initScope']
        
    isActive: (klass, deps) ->
        if @options.enabled and klass.mixins
            if !deps.$scope
                throw new Error "You need to inject `$scope` to use the watch object"
                return false

            return true

    init: (klass, deps, module) ->
        if @isActive klass, deps
            for mixin in klass.mixins
                mixin = @$controller mixin, 
                    $scope: deps.$scope
                    $element: deps.$element
                    $attrs: deps.$attrs
                    
                for key, fn of mixin.constructor::
                    if angular.isFunction(fn) and !(key in @options.ignore)
                        klass[key] = angular.bind(klass, fn)
                        
        return