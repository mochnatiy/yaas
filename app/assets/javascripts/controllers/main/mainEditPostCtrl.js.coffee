@EditPostCtrl = ($scope, $routeParams, $location, postData, alertService) ->

  $scope.data = postData.data
  postData.loadPosts(null)

  post = _.findWhere(postData.data.posts, { id: parseInt($routeParams.postId) })

  $scope.formData =
    currentPostId: post.id
    currentPostTitle: post.title
    currentPostBody: post.body

  $scope.navNewPost = ->
    $location.url('/posts/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.updatePost = ->
    postData.updatePost($scope.formData, alertService)

@EditPostCtrl.$inject = ['$scope', '$routeParams', '$location', 'postData', 'alertService']
