const String categoryId = 'id';
const String categoryName = 'name';
const String categoryAvailable = 'available';
const String categoryProductCount = 'productCount';

class CategoryModel {
  String? id, name;
  bool available;
  num productCount;

  CategoryModel({this.id, this.name, this.available = true, this.productCount = 0});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      categoryId : id,
      categoryName : name,
      categoryProductCount : productCount,
      categoryAvailable : available,
    };
  }
  factory CategoryModel.fromMap(Map<String, dynamic>map){
    return CategoryModel(
      id: map[categoryId],
      name: map[categoryName],
      productCount: map[categoryProductCount],
      available: map[categoryAvailable],
    );
  }

}
