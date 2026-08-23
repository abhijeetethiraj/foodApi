import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodapi/Api/api_service.dart';
import 'package:foodapi/Api/endpoints.dart';
import 'package:foodapi/models/food_model.dart';

class FoodProvider extends ChangeNotifier{
  final ApiService _apiService = ApiService();

  List<FoodModel> _availableFoods = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FoodModel> get availableFood =>_availableFoods;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future <void> fetchFoods() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _apiService.get(Endpoints.mealsByCategory('Seafood'));

    if(response.isSuccess){
      final List meals = response.data['meals'];
      _availableFoods = [];
      
      for(int i = 0; i< meals.length; i++){
        var item = meals[i];
        _availableFoods.add(
          FoodModel(
            id: item['idMeal'],
            name:item['strMeal'],
            restautrant: "Ocean Fresh Kitchen",
            price: 12.50 + (i * 1.50),
            image: item['strMealThumg'],

          )
        );
      }
    }else{
      _errorMessage = response.erroMessage;
    }
    _isLoading  = false;
    notifyListeners();
  }

}