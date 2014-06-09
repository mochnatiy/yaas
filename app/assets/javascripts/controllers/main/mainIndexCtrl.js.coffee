@IndexCtrl = ($scope, $location, $http, postData) ->

  $scope.data = postData.data

  postData.loadPosts(null)
       
  $scope.viewPost = (postId) ->
    $location.url('/posts/' + postId)

  $scope.navNewPost = ->
    $location.url('/posts/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', 'postData']
