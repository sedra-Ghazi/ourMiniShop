
import 'package:flutter_application_5/core/data/models/product_model.dart';
import 'package:flutter_application_5/core/data/models/category_model.dart';
import 'package:flutter_application_5/core/enum/data_type.dart';
import 'package:flutter_application_5/main.dart';

final SharedPreferencesRepository storage = SharedPreferencesRepository.instance;

class SharedPreferencesRepository {
static final SharedPreferencesRepository _instance =
SharedPreferencesRepository._internal();
static SharedPreferencesRepository get instance => _instance;
SharedPreferencesRepository._internal();

static const String prefFirstLaunch = 'PREF_FIRST_LAUNCH';
static const String productListKey = 'PREF_PRODUCT_LIST';
static const String categoryListKey = 'PREF_CATEGORY_LIST';


void setCategoryList(List<CategoryModel> list) {
setPreference(
dataType: DataType.STRING,
key: categoryListKey,
value: CategoryModel.encode(list),
);
}

List<CategoryModel> getCategoryList() {
if (globalSharedPrefs!.containsKey(categoryListKey)) {
final String jsonString = getPreference(key: categoryListKey);
if (jsonString.isNotEmpty) {
try {
return CategoryModel.decode(jsonString);
} catch (e) {
print('Error parsing categories: $e');
return [];
}
}
}
return [];
}

void addCategory(CategoryModel category) {
final List<CategoryModel> currentList = getCategoryList();
currentList.add(category);
setCategoryList(currentList);
}

void updateCategory(CategoryModel updatedCategory) {
final List<CategoryModel> currentList = getCategoryList();
final index = currentList.indexWhere((category) => category.id == updatedCategory.id);

if (index != -1) {
currentList[index] = updatedCategory;
setCategoryList(currentList);
}
}

void deleteCategory(String categoryId) {
final List<CategoryModel> currentList = getCategoryList();
currentList.removeWhere((category) => category.id == categoryId);
setCategoryList(currentList);
}


void updateCategoryProductCount(String categoryId) {
final List<CategoryModel> categories = getCategoryList();
final List products = getProductList();

final int productCount = products.where((product) => product.category == categoryId).length;

final index = categories.indexWhere((category) => category.id == categoryId);
if (index != -1) {
categories[index] = CategoryModel(
categoryname: categories[index].categoryname,
desciption: categories[index].desciption,
productcount: productCount,
id: categories[index].id,
);
setCategoryList(categories);
}
}


int getProductCountByCategory(String categoryId) {
final List products = getProductList();
return products.where((product) => product.category == categoryId).length;
}

List getProductsByCategory(String categoryId) {
final List products = getProductList();
return products.where((product) => product.category == categoryId).toList();
}


void setProductList(List<ProductModel> list) {
setPreference(
dataType: DataType.STRING,
key: productListKey,
value: ProductModel.encode(list),
);
}

List<ProductModel> getProductList() {
if (globalSharedPrefs!.containsKey(productListKey)) {
final String jsonString = getPreference(key: productListKey);
if (jsonString.isNotEmpty) {
return ProductModel.decode(jsonString);
}
}
return [];
}

void addProduct(ProductModel product) {
final List<ProductModel> currentList = getProductList();
currentList.add(product);
setProductList(currentList);

updateCategoryProductCount(product.category!);
}

void updateProduct(ProductModel updatedProduct) {
final List<ProductModel> currentList = getProductList();
final index = currentList.indexWhere((product) => product.id == updatedProduct.id);

if (index != -1) {
currentList[index] = updatedProduct;
setProductList(currentList);


updateCategoryProductCount(updatedProduct.category!);
}
}

void deleteProduct(String productId) {
final List<ProductModel> currentList = getProductList();
final product = currentList.firstWhere((p) => p.id == productId);
currentList.removeWhere((product) => product.id == productId);
setProductList(currentList);

if (product != null && product.category != null) {
updateCategoryProductCount(product.category!);
}
}



setFirstLaunch(bool value) {
setPreference(dataType: DataType.BOOL, key: prefFirstLaunch, value: value);
}

bool getFirstLaunch() {
if (globalSharedPrefs!.containsKey(prefFirstLaunch)) {
return getPreference(key: prefFirstLaunch);
} else {
return true;
}
}

 void setPreference({
required DataType dataType,
required String key,
required dynamic value,
}) async {
switch (dataType) {
case DataType.INT:
await globalSharedPrefs!.setInt(key, value);
break;
case DataType.BOOL:
await globalSharedPrefs!.setBool(key, value);
break;
case DataType.STRING:
await globalSharedPrefs!.setString(key, value);
break;
case DataType.DOUBLE:
await globalSharedPrefs!.setDouble(key, value);
break;
case DataType.LISTSTRING:
await globalSharedPrefs!.setStringList(key, value);
break;
}
}

dynamic getPreference({required String key}) {
return globalSharedPrefs!.get(key);
}



}
















