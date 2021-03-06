// Generated by CoffeeScript 1.7.1
(function() {
  var mixins_module,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  mixins_module = angular.module('classy-mixins', ['classy-core']);


  /*
      TODO: Note that this does NOT get the mixin class dependencies as of now.
      Should probably do something similar to extends?
   */

  mixins_module.classy.plugin.controller({
    name: 'mixins',
    localInject: ['$controller'],
    options: {
      enabled: true,
      ignore: ['constructor', 'init', 'initScope']
    },
    isActive: function(klass, deps) {
      if (this.options.enabled && klass.mixins) {
        if (!deps.$scope) {
          throw new Error("You need to inject `$scope` to use the watch object");
          return false;
        }
        return true;
      }
    },
    init: function(klass, deps, module) {
      var fn, key, mixin, _i, _len, _ref, _ref1;
      if (this.isActive(klass, deps)) {
        _ref = klass.mixins;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          mixin = _ref[_i];
          mixin = this.$controller(mixin, {
            $scope: deps.$scope,
            $element: deps.$element,
            $attrs: deps.$attrs
          });
          _ref1 = mixin.constructor.prototype;
          for (key in _ref1) {
            fn = _ref1[key];
            if (angular.isFunction(fn) && !(__indexOf.call(this.options.ignore, key) >= 0)) {
              klass[key] = angular.bind(klass, fn);
            }
          }
        }
      }
    }
  });

}).call(this);
