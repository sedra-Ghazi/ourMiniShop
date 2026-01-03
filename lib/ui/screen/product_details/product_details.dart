import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/data/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name ?? '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 111, 59, 201),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: widget.product.image != null
                        ? Image.asset(widget.product.image!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  widget.product.desciption ?? 'No Discreption',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    
                  ),
                  textAlign: TextAlign.right,
                ),
              ),

              SizedBox(height: 25),

              
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Text(
                      '${widget.product.price?.toString() ?? '0'} ',
                      
                    ),
                  ),

                  SizedBox(width: 12),



                   Container(
                     width: 100,
                    height: 50,
                     decoration: BoxDecoration(
                       color: const Color.fromARGB(255, 101, 30, 152),
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(
                         color: const Color.fromARGB(255, 175, 64, 255),
                       ),
                     ),
                     child: Text(
                       '${widget.product.count?.toString() ?? '0'} items',
                     ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}}
