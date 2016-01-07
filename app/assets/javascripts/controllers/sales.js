'use strict';

/**
 * @ngdoc function
 * @name cloudPosApp.controller:SalesctrlCtrl
 * @description
 * # SalesctrlCtrl
 * Controller of the cloudPosApp
 */
angular.module('cloudPosApp')
  .controller('SalesCtrl', [ '$scope', 'productSvc', function ($scope, productSvc) {

  var promise = productSvc.fetchAll();

  promise.then(
  	function(response) {
  		$scope.products = response.data;
  	},
  	function(response) {
  		console.log(response.data);
  	}
  );

	$scope.productBoards = [
       {
    	   name: 'Favorites',
    	   products: ['00001', '00002']
       },
       {
    	   name : 'Hot Drinks',
    	   products: ['00001', '00002', '00003', '00004', '00005']
       },
       {
    	   name: 'Soft Drinks',
    	   products: [ ]
       },
       {
    	   name: 'Pastry',
    	   products: [ ]
       },
       {
    	   name: 'Cakes & Pies',
    	   products: [ ]
       },
       {
    	   name: 'Soups',
    	   products : [ ]
       },
       {
    	   name: '...',
    	   products: [ ]
       }
    ];

	$scope.total = 0;

	$scope.itemList = [];

	$scope.itemList.addItem = function(prod) {
		var i = 0;
		var found = false;

		while (!found && i < this.length) {
			if (this[i].id === prod.id) {
				this[i].qty += 1;
				found = true;
			}
			++i;
		}
		if (!found) {
			prod.qty = 1;
			this.push(prod);
		}
		$scope.total += prod.retail_options[0].price; //TODO handle distinct retail options
	};

	$scope.itemList.removeItem = function(pCode) {
		var i = 0, price = 0;
		var found = false;

		while (!found && i < this.length) {
			if (this[i].id === pCode) {
				price = this[i].retail_options[0].price;
				if (this[i].qty === 1) {
					this.splice(i,1);
				}
				else {
					this[i].qty -= 1;
				}
				$scope.total -= price;  //TODO handle distinct retail options
				found = true;
			}
			++i;
		}
	};

	$scope.itemList.removeAll = function(pCode) {
		var i = 0;
		var found = false;

		while (!found && i < this.length) {
			if (this[i].id === pCode) {
				$scope.total -= this[i].qty * this[i].retail_options[0].price;
				this.splice(i,1);
				found = true;
			}
			++i;
		}
	};
}]);
