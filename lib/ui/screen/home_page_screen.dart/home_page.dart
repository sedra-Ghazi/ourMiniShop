import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/data/models/product_model.dart';
import 'package:flutter_application_5/core/data/models/category_model.dart';
import 'package:flutter_application_5/core/data/repository/shared_preference.dart';
import 'package:flutter_application_5/ui/screen/add_edit_screen/add_edit_category_screen.dart';
import 'package:flutter_application_5/ui/screen/add_edit_screen/add_edit_screen.dart';
import 'package:flutter_application_5/ui/screen/product_details/product_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  List _categories = [];
  List _products = [];

  @override
  void initState() {
    super.initState();
    _initializeAndLoadData();
  }

  Future _initializeAndLoadData() async {
    setState(() {});

    final categories = storage.getCategoryList();
    final products = storage.getProductList();

    setState(() {
      _categories = categories;
      _products = products;
    });
  }

  void _refreshData() {
    setState(() {
      _categories = storage.getCategoryList();
      _products = storage.getProductList();
    });
  }

  int _getProductCountForCategory(String categoryId) {
    return storage.getProductCountByCategory(categoryId);
  }

  List _getProductsByCategory(String categoryId) {
    return storage.getProductsByCategory(categoryId);
  }

  String _getCategoryName(String categoryId) {
    final category = _categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => CategoryModel(categoryname: 'غير معروف', id: ''),
    );
    return category.categoryname ?? 'غير معروف';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OurMiniShop',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 173, 136, 206),
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(' What Do You Want to Add|Edit..?'),
                    content: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditScreen(
                                  onSave: _initializeAndLoadData,
                                ),
                              ),
                            );
                          },
                          child: Text("Product"),
                        ),
                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditCategoryScreen(
                                  onSave: _initializeAndLoadData,
                                ),
                              ),
                            );
                          },
                          child: Text("Category"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'الإجمالي: ${_categories.length}',
                //   style: TextStyle(fontSize: 14, color: Colors.grey),
                // ),
              ],
            ),
          ),
          SizedBox(height: 10),
          _buildCategoriesHorizontalScroll(),
          SizedBox(height: 20),
          // قسم المنتجات (السكرول العمودي)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: _buildProductsGrid()),
        ],
      ),
    );
  }

  Widget _buildCategoriesHorizontalScroll() {
    if (_categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No Categories To Show ',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final productCount = _getProductCountForCategory(category.id!);

          return Container(
            width: 140,
            margin: EdgeInsets.only(right: 12),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  _showCategoryProducts(category);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.categoryname ?? ' ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 169, 144, 199),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${productCount}Product',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        category.desciption ?? '',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid() {
    if (_products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Np Product available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      padding: EdgeInsets.all(16),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(ProductModel product) {
    final bool isAvailable = product.isavilable ?? true;

    return InkWell(
      onTap: () {
        if (product.isavilable ?? true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: isAvailable ? Colors.white : Colors.grey[200],
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: product.image != null && product.image!.isNotEmpty
                        ? Image.asset(
                            product.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Image.asset("assets/BUTTERFLY PARFUM.PNG"),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.grey[500],
                              size: 50,
                            ),
                          ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isAvailable
                                ? Colors.black
                                : Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${(product.price ?? 0)} ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 139, 52, 237),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.inventory, size: 12, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              'Quantity: ${product.count ?? 0}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          _getCategoryName(product.category ?? ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (!isAvailable)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.block, size: 40, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          'Unavailable',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCategoryProducts(CategoryModel category) {
    final categoryProducts = _getProductsByCategory(category.id!);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            category.categoryname ?? '',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            category.desciption ?? '',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'product number : ${_getProductCountForCategory(category.id!)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 142, 88, 242),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              if (categoryProducts.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No products Here',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: categoryProducts.length,
                    itemBuilder: (context, index) {
                      final product = categoryProducts[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                                product.image != null &&
                                    product.image!.isNotEmpty
                                ? NetworkImage(product.image!)
                                : null,
                            child:
                                product.image == null || product.image!.isEmpty
                                ? Icon(Icons.shopping_bag)
                                : null,
                          ),
                          title: Text(product.name ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${(product.price ?? 0)} '),
                              Text('Quantity: ${product.count ?? 0}'),
                            ],
                          ),
                          trailing: (product.isavilable ?? true)
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.lightGreenAccent,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: const Color.fromARGB(
                                    255,
                                    101,
                                    30,
                                    152,
                                  ).withOpacity(0.3),
                                ),
                          onTap: (product.isavilable ?? true)
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}