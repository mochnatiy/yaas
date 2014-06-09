angular.module('Blog').factory('alertService', ['$rootScope', ($rootScope) ->
  $rootScope.alerts = []
  alertService = 
    add: (type, msg) ->
      $rootScope.alerts.push { type: type, msg: msg, close: -> alertService.closeAlert(this) } 
    closeAlert: (alert) ->
      @closeAlertIdx $rootScope.alerts.indexOf(alert)
    closeAlertIdx: (index) ->
      $rootScope.alerts.splice index, 1
  ])
