
class CategoryModel {

   final String? categoryId;
   final String? categoryName;
   final String? categoryDescription;
   final String? categoryImage;

  CategoryModel({ this.categoryId,  this.categoryName, this.categoryDescription,  this.categoryImage});

  Map<String,dynamic> toMap(){
    return {
      'category_id' : categoryId,
      'category_name' : categoryName,
      'category_description' : categoryDescription,
      'category_image' : categoryImage
    };
  }

  CategoryModel.fromFirestore(Map<String,dynamic> firestore)
      : categoryId = firestore['category_id'],
        categoryName = firestore['category_name'],
        categoryDescription = firestore['category_description'],
        categoryImage = firestore['category_image'];
}


