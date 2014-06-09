@PostCtrl = ($scope, $routeParams, $location, $q, postData, alertService) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Загружаем...'
      body: ''

  $scope.data.postId = $routeParams.postId

  $scope.navNewPost = ->
    $location.url('/posts/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.id = post.id
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.body = post.body
    $scope.data.currentPost.timestamp = post.timestamp

  $scope.deletePost = ->
    postData.deletePost($scope.data.currentPost, alertService)

  $scope.editPost = (postId) ->
    $location.url('/posts/' + postId + '/edit')

  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)

  postData.loadPosts(@deferred)


@PostCtrl.$inject = ['$scope', '$routeParams', '$location', '$q', 'postData', 'alertService']
