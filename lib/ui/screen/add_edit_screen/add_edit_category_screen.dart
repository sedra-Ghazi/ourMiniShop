// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/data/models/category_model.dart';
import 'package:flutter_application_5/core/data/repository/shared_preference.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final VoidCallback onSave;
  // final ModelType? modelType;
   final CategoryModel? categoryModel;
   

  // ignore: use_super_parameters
  const AddEditCategoryScreen({
    Key? key,
    this.categoryModel,
    required this.onSave,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // switch (widget. modelType!= null) {
    //   case ModelType.ProductModel:{
    //   final ProductModel? productModel;
        
    //     break;}
    //   default:
    // }



    if (widget. categoryModel!= null) {
      nameController.text = widget.categoryModel!.categoryname!;
      descriptionController.text = widget.categoryModel!.desciption!;
    
    }
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
     
      //final String id = DateTime.now().millisecondsSinceEpoch.toString();
      
      
       final newCategory = CategoryModel(
                    categoryname: nameController.text,
                    desciption: descriptionController.text,
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                  );

      if (widget.categoryModel == null) {
        storage.addCategory(newCategory);
      } else {
        storage.updateCategory(newCategory);
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
        title: Text(widget.categoryModel == null ? 'Add  New Category' : 'Edit Category'),
       
       
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
                    labelText: 'Categoryname',
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