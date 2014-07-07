﻿# Test Data

app = angular.module 'app', [
    'classy'
    'classy-extends'
]
 
app.factory 'TestService', ->
    ->
        'Test'
        
app.classy.controller
    name: 'ParentCtrl'
   
    inject: ['$scope', 'TestService']
   
    init: ->
        @logs = []
        return
      
    baseFunc: ->
        @logs.push 'This only exists on the parent'
        return
          
    someFunc: ->
        @logs.push 'Parent'
        return
 
app.classy.controller
    name: 'ChildCtrl'
    extends: 'ParentCtrl'
   
    init: ->
        @_super arguments
        return
        
    someFunc: ->
        @_super arguments
        @logs.push 'Child'
        return
        
    getServiceText: ->
        @TestService()
    
# Tests

describe 'Classy extends (classy-extends.coffee)', ->
    beforeEach module 'app'
    
    childController = null
    scope = null
    
    beforeEach ->
        inject ($controller, $rootScope) ->
            scope = $rootScope.$new()
            childController = $controller 'ChildCtrl', 
                $scope: scope
            return
        return
    
    it 'should call the base class function if the function does not exist on the child class', ->
        scope.baseFunc()
        expect(childController.logs).toEqual ['This only exists on the parent']
        return
        
    it 'should be able to call the super function', ->
        scope.someFunc()
        expect(childController.logs).toEqual ['Parent', 'Child']
        return
        
    it 'should inject base class dependencies correctly', ->
        expect(scope.getServiceText()).toBe 'Test'
        return
        
    return
    