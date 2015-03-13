controllers = angular.module('controllers')
controllers.controller("PiController", [ '$scope', '$routeParams', '$location', '$resource', 'flash', '$http',
  ($scope,$routeParams,$location,$resource,flash,$http)->

    $scope.overallHits = 0
    $scope.overallIterations = 0
    $scope.totalIterations = 0
    $scope.totalHits = 0
    $scope.lastPi = "-"
    $scope.iterations = 10000000
    $scope.iterationResults = []

    $scope.piTrial = ->
      hits = runTrial($scope.iterations)
      $scope.iterationResults.push( {i:$scope.iterations,h:hits} )
      saveResult($scope.iterations,hits)
      $scope.lastPi = 4*hits/$scope.iterations
      getGrandTotals()

    $scope.yourPi = ->
      if $scope.totalHits > 0
        return 4*$scope.totalHits/$scope.totalIterations
      else
        return "-"

    $scope.overallPi = ->
      return 4*$scope.overallHits/$scope.overallIterations

    runTrial = (iterations) -> 
      hits = 0
      for i in [0..iterations]
        x = Math.random()
        y = Math.random()
        if (x*x + y*y < 1) 
          hits += 1
      $scope.totalHits += hits
      $scope.totalIterations += iterations
      return hits

    getGrandTotals = ->
      $http.get('/totals').success (data)->  
        $scope.overallHits =       data['hits']
        $scope.overallIterations = data['iterations']

    Result = $resource('/results/:id', { id: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    saveResult = (i,h) ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      Result.create({hits:h,iterations:i},onError)

    getGrandTotals()

])