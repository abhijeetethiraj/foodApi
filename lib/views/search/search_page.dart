import 'package:flutter/material.dart';
import 'package:foodapi/models/food_model.dart';
import 'package:foodapi/provider/cart_provider.dart';
import 'package:foodapi/viewmodels/search_viewmodel.dart';
import 'package:foodapi/views/details/food_details_page.dart';
import 'package:foodapi/views/widgets/food.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewmodel>();
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                onSubmitted: (Value){
                  vm.searchMeal(Value);
                },
                decoration: InputDecoration(
                  hintText: "Search food...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 30),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.searchMeals.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsetsGeometry.only(bottom: 20),
                    child: SizedBox(
                      height: 340,
                      child: FoodCard(
                        meal: vm.searchMeals[index],
                        onTap: (){
                          final meal = vm.searchMeals[index];
                          final price = (120 + meal.idMeal.hashCode % 250).toDouble();
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                              builder: (_)=>FoodDetailsPage(
                                meal: meal,
                                 price: price,
                                 ),
                                 ),
                             );
                        },
                        onAddToCart: () async {

                          final meal = vm.searchMeals[index];
                          final price = (120 + meal.idMeal.hashCode % 250).toDouble();
                          
                          try {
                            await context.read<CartProvider>().addTOCart(
                              FoodModel(
                                id: meal.idMeal, 
                                name: meal.strMeal,
                                 restautrant: 'Restaurant',
                                  price: price,
                                   image: meal.strMealThumb
                                   ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${meal.strMeal} added tocart'),
                                  duration: const Duration(seconds: 1),
                                  )
                              );
                          } catch (error) {
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to add to cart: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                            
                          
                        },
                        ),
                    ),
                    );
                }
                )
            ],
          ),
        )
        ),
    );
  }
}