'use strict';

/**
 * @ngdoc function
 * @name cloudPosApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the cloudPosApp
 */
angular.module('cloudPosApp')
  .controller('ProductsCtrl', [
    '$scope', '$modal', '$routeParams', '$location', 'productSvc',
    function ($scope, $modal, $routeParams, $location, productSvc) {

    $scope.categories = [ //TODO get from server through productSvc
        { "id": 1, "name": "Hot Drinks" },
        { "id": 2, "name": "Cold Drinks" },
        { "id": 3, "name": "Favorites" },
        { "id": 4, "name": "Pastry" }
    ];

    $scope.ingredients = [ //TODO get from server through productSvc
        { "id": 1, "name": 'Coffee', "unity":"kg" },
        { "id": 2, "name": 'Milk', "unity":"l"},
        { "id": 3, "name": 'Suggar', "unity":"kg" },
        { "id": 4, "name": 'Chocolate Powder', "unity":"kg"}
    ];

    $scope.selectedIngredients = [];

    $scope.selectedCategories = [];

    $scope.categoriesLocalLang = {
        selectAll       : 'Select All',
        selectNone      : 'Clear All',
        reset           : 'Reset',
        search          : 'Search...',
        nothingSelected : 'Categories...'
    };

    $scope.ingredientsLocalLang = {
        selectAll       : 'Select All',
        selectNone      : 'Clear All',
        reset           : 'Reset',
        search          : 'Search...',
        nothingSelected : 'Ingredients...'
    };

    var ingredientModal = $modal({
        scope: $scope,
        templateUrl: "templates/ingredient-modal.html",
        show: false
    });

    var optionModal = $modal({
        scope: $scope,
        templateUrl: "templates/option-modal.html",
        show: false
    });

    if ($location.path().indexOf('/new') != -1) {
        handleProductCreation();
    }
    else if ($routeParams['id'] != null) {
        handleProductUpdate($routeParams['id']);
    }
    else {
        handleError();
    }

    function handleProductCreation() {
        $scope.product = {
            "name": null,
            "image_url": "http://www.placehold.it/150x150/EFEFEF/AAAAAA&amp;text=add+image",
            "retail_options": [],
            "categories": [],
            "supplies": []
        };
    }

    function handleProductUpdate(id) {
        var promise = productSvc.fetch(id);
        promise.then(
            function(response) {
                $scope.product = response.data;
                tickCategories();
                tickIngredients();
            },
            function(response) {
                console.log(response.data);
            }
        );
    }

    function handleError() {
        console.log("Invalid Request");
        console.log($location);
        console.log($routeParams);
    }

    function tickCategories() {
        execOnMatch(
            $scope.categories,'name',
            $scope.product.categories, 'name',
            function(match) {
                match.ticked = true;
            }
        );
    }

    function tickIngredients() {
        execOnMatch(
            $scope.ingredients, 'name',
            $scope.product.supplies, 'name',
            function(match) {
                match.ticked = true;
            }
        );
    }

    function saveSelectedIngredients() {
        execOnMatch(
            $scope.ingredients, 'name',
            $scope.selectedIngredients, 'name',
            function(match) {
                match.ticked = true;
            }
        );
    	// for (var i = 0; i < $scope.selectedIngredients.length; i++) {
    	// 	var tempIngredient = $scope.selectedIngredients[i];
    	// 	for (var j = 0; j < $scope.ingredients.length; j++) {
    	// 		if (tempIngredient.name === $scope.ingredients[j].name) {
    	// 			$scope.ingredients[j].ticked = true;
    	// 		}
    	// 	}
    	// }
    }

    // function isExistent(ingred) {
    // 	var order = 0; // non existent
    // 	for (var i = 0; i < $scope.ingredients.length; i++) {
    // 		if ($scope.ingredients[i].name === ingred.name) {
    // 			order = i + 1; // order of the ingredient in the list
    // 		}
    // 	}
    // 	return order;
    // }

    $scope.showIngredientModal = function () {
    	saveSelectedIngredients();
    	ingredientModal.$promise.then(ingredientModal.show);
    };

    $scope.showOptionModal = function () {
    	saveSelectedIngredients();
        optionModal.$promise.then(optionModal.show);
    };

  //   $scope.deselectIngredient = function (index, ingred) {
		// $scope.selectedIngredients.splice(index,1);
		// var order = isExistent(ingred);
		// if (order) {
		// 	$scope.ingredients[order - 1].ticked = false;
		// }
		// saveSelectedIngredients();
  //   };

    $scope.deselectIngredient = function (index, ingred) {
        $scope.selectedIngredients.splice(index,1);
        _.map($scope.ingredients, function(item) {
            if (item.name === ingred.name) {
                item.ticked = false;
            }
        });
        saveSelectedIngredients();
    };

    $scope.addIngredient = function (ingred) {
        if (!_.findWhere($scope.ingredients, { "name": ingred.name })) {
            // add ingredient to ingredients list
            ingred.ticked = true;
            $scope.ingredients.push(ingred);
            // hide modal
            ingredientModal.hide();
        }
        else {
            // TODO handle error message
        }
    };

    $scope.addOption = function (option) {
        if (!_.findWhere($scope.product.retail_options, { "name": option.name })) {
            $scope.product.retail_options.push(option);
            // hide modal
            optionModal.hide();
        }
        else {
            // TODO handle error message
        }
    };

    $scope.saveProduct = function() {
        $scope.product.supplies = $scope.selectedIngredients;
        $scope.product.categories = $scope.selectedCategories;
        console.log($scope.product);
    }

  }]);

// $scope.product =
// {
//     "id": 1,
//     "name": "Black Coffee",
//     "image_url": "/imgs/black_coffee.jpg",
//     "retail_options": [
//         {
//             "id": 1,
//             "name":"Large",
//             "short_name":"L",
//             "description":"Large black coffee (250 ml)",
//             "price":4.0
//         }
//     ],
//     "categories": [
//         {
//             "id":1,
//             "name": "Hot Drinks",
//             "description":"Try our delicious Coffees and Teas"
//         },
//         {
//             "id":3,
//             "name":"Favorites",
//             "description":"Bestseller products"
//         }
//     ],
//     "supplies":[
//         {
//             "id":1,
//             "name":"Coffee Beans",
//             "unity":"kg"
//         }
//     ]
// };
