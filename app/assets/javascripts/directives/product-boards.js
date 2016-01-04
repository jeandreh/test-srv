'use strict';

/**
 * @ngdoc directive
 * @name cloudPosApp.directive:productBoards
 * @description
 * # productBoards
 */
angular.module('cloudPosApp')
  .directive('productBoards', function () {
 	return {
 		restrict: 'E',
 		template:
 		'<nav class="navbar navbar-default" role="navigation">\
 			<div class="container-fluid">\
 				<div class="navbar-header">\
	 				<button type="button" class="navbar-toggle"data-toggle="collapse" data-target="#product-board">\
	 					<span class="icon-bar"></span>\
	 					<span class="icon-bar"></span>\
	 					<span class="icon-bar"></span>\
	 				</button>\
 				</div>\
	 			<div class="navbar-collapse collapse" id="product-board">\
	 				<ul class="nav navbar-nav">\
	 					<li ng-class="{active: isSelected($index)}"ng-repeat="board in productBoards" id="tab_{{$index}}">\
	 						<a href="" ng-click="setCurrentTab($index)">{{board.name}}</a>\
	 					</li>\
	 				</ul>\
	 			</div>\
 			</div>\
 		</nav>\
 		<div class="row placeholders" ng-repeat="board in productBoards"ng-show="isSelected($index)" id="board_{{$index}}">\
 			<div class="col-xs-6 col-sm-3 placeholder" ng-repeat="product in products">\
 				<a href="" ng-click="addProduct(product)" class="thumbnail">\
 					<img class="img img-rounded img-responsive" ng-src="{{product.image_url}}">\
 					<h4 class="text text-center">{{product.name}}</h4>\
 				</a>\
 			</div>\
 		</div>',
 		link: function($scope) {
 			//	$scope.products = productSvc.products();
 			$scope.currentTab = 0;

 			$scope.isSelected = function (tab) {
 				return $scope.currentTab === tab;
 			};

 			$scope.setCurrentTab = function (tab) {
 				$scope.currentTab = tab;
 			};

 			$scope.addProduct = function (prod) {
 				$scope.itemList.addItem(prod);
 			};
 		}
 	};
});
