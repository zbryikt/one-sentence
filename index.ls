angular.module \main, <[]>
  ..controller \main, <[$scope $http $interval]> ++ ($scope, $http, $interval) ->
    $scope.posts = []
    $scope.pending = []
    $scope.feeding = ->
      $scope.handler = $interval (-> if $scope.pending.length =>
        idx = parseInt(Math.random! * $scope.pending.length)
        [id,title] = $scope.pending.splice idx, 1 .0
        feed id, title
      ), 1000
    token = \CAACEdEose0cBALttLAoxbjzArHlSVjWMY5BQIgYD8FiFkIXLCnVuTdVPYJfvueDZB6FVbhusb8wLSn42SZAtzGtaWcd3ZAec6FyKbUIbbNcZCnbZBN47khfTdNOaj4Qsk77qo5AGZCmPpWVpZCvgTFSsaCOrGcEw47Yr1kEE9erDBngbsI5wIHgZAfB76Gn97ucmo4FnanywxjzhH9Ydh8kV
    url = \https://graph.facebook.com/v2.4/search
    params = do
      q: \一句話惹怒
      type: \event
      access_token: token
      format: \json
      method: \GET
      pretty: 0
      limit: 100

    $http do
      url: url
      params: params
      method: \GET
    .success (d) ->
      $scope.list = d.data
      $scope.pending = $scope.list.map(-> [it.id, it.name])
      $scope.feeding!
    feed = (id, title) ->
      url = "https://graph.facebook.com/v2.4/#id/feed"
      params = do
        access_token: token
        limit: 5
      $http {url, params, method: \GET}
        .success (d) ->
          d.data.map -> 
            it.board = title
            it.timestamp = new Date(it.updated_time).getTime!
          $scope.posts ++= d.data
        .error (d) -> $interval.cancel $scope.handler


