@CreatePostCtrl = ($scope, $location, postData, alertService) ->

  $scope.data = postData.data
  postData.loadPosts(null)

  $scope.formData =
    newPostTitle: ''
    newPostBody: ''

  $scope.navNewPost = ->
    $location.url('/posts/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.createPost = ->
    postData.createPost($scope.formData, alertService)

  $scope.clearPost = ->
    $scope.formData.newPostTitle = ''
    $scope.formData.newPostBody = ''

@CreatePostCtrl.$inject = ['$scope', '$location', 'postData', 'alertService']
