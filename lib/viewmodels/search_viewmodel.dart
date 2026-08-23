 import 'package:flutter/material.dart';
import 'package:foodapi/Api/api_service.dart';
import 'package:foodapi/Api/endpoints.dart';
import 'package:foodapi/models/meal_model.dart';

class SearchViewmodel  extends ChangeNotifier{
  final ApiService _apiService = ApiService();

  bool isLodaing = false;
  String errorMessage ="";
  List<Meal> searchMeals = [];

  Future <void> searchMeal(String mealName) async {
    if(mealName.trim().isEmpty){
      searchMeals.clear();
      notifyListeners();
      return;
    }

    isLodaing = true;
    errorMessage = "";
    notifyListeners();
    final response = await _apiService.get(
      Endpoints.searchMeal(mealName),
    );

    if(response.isSuccess){
      final data = MealResponse.fromJson(response.data);
      searchMeals = data.meals;
    }else{
     searchMeals = [];
     errorMessage = response.erroMessage ?? "No meals found";
    }

    isLodaing = false;
    notifyListeners();
  }

  void clearSearch(){
    searchMeals.clear();
    errorMessage ="";
    notifyListeners();
  }

  
 }