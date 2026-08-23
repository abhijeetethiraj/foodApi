import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodapi/Api/api_service.dart';
import 'package:foodapi/Api/endpoints.dart';
import 'package:foodapi/models/meal_model.dart';
import 'package:foodapi/views/details/food_details_page.dart';
import 'package:foodapi/views/navigation/app_shell.dart';
import 'package:foodapi/views/widgets/bottom_nav_bar.dart';

class CatergoryMealsPage extends StatelessWidget {
  final String categoryName;
  final String? categoryImgae;
  const CatergoryMealsPage({
    super.key,
    required this.categoryName,
    required this.categoryImgae,
    });

    Future<List<Meal>> _loadMeal() async {
      final Response = await ApiService().get(
        Endpoints.mealsByCategory(categoryName),
        );
        if(Response.isSuccess){
          return MealResponse.fromJson(Response.data).meals;
        }
        return [];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<Meal>>(
        future: _loadMeal(),
         builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return const Center(child: Text('Unable to load meals'));
          }
          final meals = snapshot.data ?? [];
          if(meals.isEmpty){
            return const Center(child: Text('No meals found for this category'));
          }
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(categoryImgae != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Image.network(
                  categoryImgae!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '$categoryName foods',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: meals.length,
                    itemBuilder: (context , index){
                      final meal = meals[index];
                      final price = (120 + meal.idMeal.hashCode % 250).toDouble();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder:(_)=> FoodDetailsPage(
                                  meal: meal, 
                                  price: price,
                                  ),
                                   ),
                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    meal.strMealThumb,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            meal.strMeal,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )
                                        ),
                                        const SizedBox(height: 8),
                                         Text(
                                        '₹ ${price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                         ),
                                      ],
                                    ),
                                    )
                                  )
                              ],
                            ),
                          ),
                        ),
                        );
                    },
                  )
                  )
          ],
          );
         }),
         bottomNavigationBar: BottomNavBar(
          currentIndex: 0,
          onTap: (index){
            Navigator.pushReplacement(context,
             MaterialPageRoute(
              builder: (_)=> AppShell(initialIndex: index),
              ),
              );
          },
         ),

    );
  }
}