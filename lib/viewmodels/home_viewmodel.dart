import 'package:flutter/material.dart';
import 'package:foodapi/Api/api_service.dart';
import 'package:foodapi/Api/endpoints.dart';
import 'package:foodapi/models/category_model.dart';
import 'package:foodapi/models/meal_model.dart';

class HomeViewmodel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> categories = [];

  bool isLoading = false;
  String erroMessage = '';
  List<Meal> meals = [];

  Meal? feautureMeal;
  String selectedCategory = "";

  Future<void> getRandomMeal() async {
    final response = await _apiService.get(Endpoints.randomMeal);

    if (response.isSuccess) {
      feautureMeal = MealResponse.fromJson(response.data).meals.first;
    }
  }

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();
    await getRandomMeal();
    final response = await _apiService.get(Endpoints.categories);

    if (response.isSuccess) {
      final categoryResponse = CatergoryResponse.fromJson(response.data);

      categories = categoryResponse.meals;

      for (final catergory in categories) {
        final mealResponse = await _apiService.get(
          Endpoints.mealsByCategory(catergory.strCategory),
        );
        if (mealResponse.isSuccess) {
          final meals = MealResponse.fromJson(mealResponse.data).meals;

          if (meals.isNotEmpty) {
            catergory.thumbnail = meals.first.strMealThumb;
          }
        }
      }

      if (categories.isNotEmpty) {
        await getMealsByCategory(categories.first.strCategory);
      }
    } else {
      erroMessage = response.erroMessage ?? "Something went Wrong";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMealsByCategory(String category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();

    final response = await _apiService.get(Endpoints.mealsByCategory(category));

    if(response.isSuccess){
      final mealResponse = MealResponse.fromJson(response.data);
      meals = mealResponse.meals;
      erroMessage = '';

    }else{
         erroMessage = response.erroMessage ?? 'Something went wrong';
    }

    isLoading = false;
    notifyListeners();
  }
}
