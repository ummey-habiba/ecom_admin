import 'package:ecom_admin/db/db_helper.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier{
List <CategoryModel> categoryList=[];
List<ProductModel> productList= [];
  Future<void> addNewCategory(String name){
    final model = CategoryModel(name);
    return DbHelper.addCategory(model);
  }

  Future<void> addNewProduct(ProductModel model){
    return DbHelper.addProduct(model);
  }
getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot){
      categoryList=List.generate(snapshot.docs.length, (index)=>CategoryModel.fromMap(snapshot.docs[index].data()));
    });
}
ProductModel getProductFromListById(String id){
    return productList.firstWhere((product)=> product.id== id);
}

getAllProducts(){
  DbHelper.getAllProducts().listen((snapshot){
    productList=List.generate(snapshot.docs.length, (index)=>ProductModel.fromMap(snapshot.docs[index].data()));
  });
}
Future<void> updateSingleProductField(String id , String field,dynamic value){
    return DbHelper.updateSingleProductField(id, field, value);
}

}