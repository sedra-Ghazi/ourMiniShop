// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/data/models/product_model.dart';
import 'package:flutter_application_5/core/data/repository/shared_preference.dart';

class AddEditScreen extends StatefulWidget {
  final VoidCallback onSave;
  // final ModelType? modelType;
   final ProductModel? productModel;
   

  const AddEditScreen({
    super.key,
    this.productModel,
    required this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController countController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // switch (widget. modelType!= null) {
    //   case ModelType.ProductModel:{
    //   final ProductModel? productModel;
        
    //     break;}
    //   default:
    // }



    if (widget. productModel!= null) {
      nameController.text = widget.productModel!.name!;
      descriptionController.text = widget.productModel!.desciption!;
      priceController.text = widget.productModel!.price?.toString()??'';
      countController.text = widget.productModel!.count?.toString()??'';
      imageController.text = widget.productModel!.image!;
      categoryController.text = widget.productModel!.category!;
      isAvailable=widget.productModel!.isavilable?? true;
    }
  }
  bool isAvailable = true;

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
     
      //final String id = DateTime.now().millisecondsSinceEpoch.toString();
      
      
       final newProduct = ProductModel(
                    name: nameController.text,
                    desciption: descriptionController.text,
                    price: int.tryParse(priceController.text) ?? 0,
                    count: int.tryParse(countController.text) ?? 0,
                    image: imageController.text.isNotEmpty
                        ? imageController.text
                        : null,
                    category: categoryController.text,
                    isavilable: isAvailable,
                  
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                  );

      if (widget.productModel == null) {
        storage.addProduct(newProduct);
      } else {
        storage.updateProduct(newProduct);
      }

      
    

      
      widget.onSave();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.productModel == null ? 'Add  New Product' : 'Edit Product'),
       
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               
               TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: countController,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                
              
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value ?? true;
                        });
                      },
                    ),
                  ],
                ),

                 ElevatedButton(
                  onPressed: _saveCard,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}