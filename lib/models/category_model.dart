

class CatergoryResponse{
  final List <Category> meals;

  CatergoryResponse({
    required this.meals,
  });

  factory CatergoryResponse.fromJson(Map<String,dynamic> json){
    return CatergoryResponse(
      meals: (json['meals'] as List)
      .map((e)=> Category.fromJson(e))
      .toList(),
      );
  }
    
  
}

class Category {
  final String strCategory;
  String? thumbnail;

  Category({
    required this.strCategory,
    this.thumbnail,
  });
 
  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
      strCategory: json['strCategory'],
      );
  }
}