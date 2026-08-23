class Endpoints {
   static const String baseUrl =  "https://www.themealdb.com/api/json/v1/1";

   static const String categories = "$baseUrl/list.php?c=list";

   static  String mealsByCategory (String category) => "$baseUrl/filter.php?c=$category";

   static  String searchMeal(String meal) => "$baseUrl/search.php?s=$meal";

    static String mealDetails(String id) => "$baseUrl/lookup.php?i=$id";
  
  static const String randomMeal = "$baseUrl/random.php";

}