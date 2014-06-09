angular.module('Blog').factory('postData', ['$http', '$location', ($http, $location) ->

  postData =
    data:
      posts: [{ title: 'Loading', body: '' }]
    isLoaded: false

  postData.loadPosts = (deferred) ->
    if !postData.isLoaded
      $http.get('/api/posts.json').success( (data) ->
        postData.data.posts = data

        angular.forEach postData.data.posts, (post) -> 
          if (parseInt(post.timestamp))
            post.timestamp = timeDisplay(post.timestamp)
          return
        
        postData.isLoaded = true
        
        if deferred
          deferred.resolve()
      ).error( ->
        # Error handler
        if deferred
          deferred.reject('Не удалось получить список статей с сервера')
      )
    else
      if deferred
        deferred.resolve()

  postData.createPost = (newPost, alertService) ->
    if newPost.newPostTitle == '' or newPost.newPostBody == ''
      alert('Заголовок и Текст должны быть заполнены')
      return false

    data =
      post:
        title: newPost.newPostTitle
        body: newPost.newPostBody

    $http.post('/api/posts.json', data).success( (data) ->
      data.timestamp = timeDisplay(data.timestamp)
      postData.data.posts.unshift(data)
      alertService.add('success', 'Статья успешно добавлена')
      $location.url('/')
    ).error( (data) ->
      alertService.add('danger', data.err_msg || 'Не удалось добавить статью')
      $location.url('/posts/new')
    )

    return true

  postData.deletePost = (currentPost, alertService) ->
    data =
      post:
        id: currentPost.id
        title: currentPost.title
        body: currentPost.body

    $http.delete('/api/posts/' + currentPost.id, data).success( (data) ->
      old_post = _.findWhere(postData.data.posts, { id: parseInt(data.id) })
      old_post_index = postData.data.posts.indexOf(old_post)

      postData.data.posts.splice(old_post_index, 1)
      alertService.add('success', 'Статья успешно удалена')
      $location.url('/')
    ).error( (data) ->
      alertService.add('danger', data.err_msg || 'Не удалось удалить статью')
      $location.url('/posts/' + currentPost.id)
    )

    return true

  postData.updatePost = (currentPost, alertService) ->
    data =
      post:
        id: currentPost.currentPostId
        title: currentPost.currentPostTitle
        body: currentPost.currentPostBody

    $http.put('/api/posts/' + currentPost.currentPostId, data).success( (data) ->
      data.timestamp = timeDisplay(data.timestamp)
      old_post = _.findWhere(postData.data.posts, { id: parseInt(data.id) })
      old_post_index = postData.data.posts.indexOf(old_post)
      
      postData.data.posts.splice(old_post_index, 1)
      postData.data.posts.splice(old_post_index, 0, data)
      alertService.add('success', 'Статья успешно обновлена')
      $location.url('/')
    ).error( (data) ->
      alertService.add('danger', data.err_msg || 'Не удалось обновить статью')
      $location.url('/posts/' + currentPost.id + '/edit')
    )

    return true

  return postData
])
