angular.module('qAnMp').controller('getCandidatesByPC', ['$scope', '$http' ,function($scope, $http){

$scope.sendPostcodeToDb = function(){
  console.log($scope.postCode, 'inside II')

  var urlPostcode = "https://stop-aidz-unity4.herokuapp.com/quizmaster/constituency_one_candidate?postcode=" + $scope.postCode
  $http.get(urlPostcode)
  .success(function(response){
  $scope.candidate = {}
   $scope.candidate.party = response.candidate_party_name
   $scope.candidate.full_name = response.candidate_name
   $scope.candidate.constituency = response.constituency_name
   $scope.candidateId = response.candidate_id
  })
  .error(function(error){
    console.log(error)
  })
  
}

}])