on_module = angular.module 'classy-on', ['classy-core']

on_module.classy.plugin.controller
    name: 'on'

    options:
        enabled: true

    isActive: (klass, deps) ->
        if @options.enabled and angular.isObject(klass.on)
            if !deps.$scope
                throw new Error "You need to inject `$scope` to use the watch object"
                return false

            return true

    postInit: (klass, deps, module) ->
        if !@isActive(klass, deps) then return

        for key, fn of klass.on
            deps.$scope.$on key, angular.bind klass, fn
        return