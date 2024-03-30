import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final dynamic userData;
  final String? documentId;

  const AddProduct({super.key, this.userData, this.documentId});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController Product_name = TextEditingController();
  TextEditingController Product_description = TextEditingController();
  TextEditingController Product_mrp = TextEditingController();
  TextEditingController Product_price = TextEditingController();
  TextEditingController product_discount = TextEditingController();
  TextEditingController Product_brand = TextEditingController();
  TextEditingController Product_color = TextEditingController();
  String? selectImage;

  @override
  void initState() {
    if (widget.documentId != null) {
      Product_name.text = widget.userData['Product_name'];
      Product_description.text = widget.userData['Product_description'];
      Product_mrp.text = widget.userData['Product mrp'].toString();
      Product_price.text = widget.userData['Product price'].toString();
      product_discount.text = widget.userData['Product price'].toString();
      Product_brand.text = widget.userData['Product_brand'];
      Product_color.text = widget.userData['Product_color'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 100),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 30,
                                          ),
                                          //
                                          child: GestureDetector(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              XFile? image =
                                              await picker.pickImage(
                                                source: ImageSource.camera,
                                              );
                                              if (image != null) {
                                                selectImage = image.path;
                                                setState(
                                                      () {},
                                                );
                                              }
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/f1/7e/4d/f17e4d91-c3f4-0e8d-101b-c4d1cf041d21/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/1200x600wa.png",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                const Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            final picker = ImagePicker();
                                            XFile? image =
                                            await picker.pickImage(
                                              source: ImageSource.gallery,
                                            );
                                            if (image != null) {
                                              selectImage = image.path;
                                              setState(
                                                    () {},
                                              );
                                            }
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              ClipOval(
                                                child: Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuVFHvYidu8HF2Jt8z0qXlxKwGC9n9qbaktw&usqp=CAU",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                              const Text(
                                                "gallery",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(
                    child: selectImage != null
                        ? Image.file(
                      File(selectImage!),
                      height: 100,
                      width: 100,
                    )
                        : widget.userData != null
                        ? Image.network(
                      height: 100,
                      width: 100,
                      widget.userData['image'].toString(),
                    )
                        : Container(
                      margin:
                      const EdgeInsets.only(top: 20, bottom: 20),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Text(widget.categoryItem.toString()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_name",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_name,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_description :",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_description,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_mrp :",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_mrp,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_price",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_price,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "product_discount",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: product_discount,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_brand :",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_color,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product_color :",
                      style: TextStyle(fontFamily: "EduTASBeginner"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: Product_brand,
                ),
                ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    );

                    if (widget.documentId != null) {
                      //   Edit

                      String id = FirebaseFirestore.instance
                          .collection('Amazon')
                          .doc()
                          .id;

                      if (selectImage != null) {
                        String fileName =
                            "${DateTime.now().millisecondsSinceEpoch}jpg";

                        Reference reference =
                        FirebaseStorage.instance.ref().child(fileName);

                        UploadTask uploadTask =
                        reference.putFile(File(selectImage!));

                        try {
                          TaskSnapshot snapshot = await uploadTask;

                          var imageUrl = await snapshot.ref.getDownloadURL();

                          print("url :   $imageUrl");

                          FirebaseFirestore.instance
                              .collection('Amazon')
                              .doc(widget.documentId)
                              .update({
                            "Product_name": Product_name.text,
                            "Product_description": Product_description.text,
                            "Product_mrp": int.parse(Product_mrp.text),
                            "image": imageUrl,
                            "Product_price": int.parse(Product_price.text),
                            "product_discount":
                            int.parse(product_discount.text),
                            "Product_brand": Product_brand.text,
                            "Product_color": Product_color.text,
                          }).whenComplete(() {
                            Navigator.pop(context);

                            Navigator.pop(context);
                          });
                        } on FirebaseException catch (e) {
                          print('Error --- ${e.message}');
                          Navigator.pop(context);
                        }
                      } else {
                        FirebaseFirestore.instance
                            .collection('Amazon')
                            .doc(widget.documentId)
                            .update({
                          "Product_name": Product_name.text,
                          "Product_description": Product_description.text,
                          "Product_mrp": int.parse(Product_mrp.text),
                          "Product_price": int.parse(Product_price.text),
                          "product_discount": int.parse(product_discount.text),
                          "Product_brand": Product_brand.text,
                          "Product_color": Product_color.text,
                        }).whenComplete(() {
                          Navigator.pop(context);

                          Navigator.pop(context);
                        });
                        // Navigator.pop(context);
                      }
                    } else {
                      //   Add

                      String id = FirebaseFirestore.instance
                          .collection('Amazon')
                          .doc()
                          .id;

                      if (selectImage != null) {
                        String fileName =
                            "${DateTime.now().millisecondsSinceEpoch}jpg";

                        Reference reference =
                        FirebaseStorage.instance.ref().child(fileName);

                        UploadTask uploadTask =
                        reference.putFile(File(selectImage!));

                        try {
                          TaskSnapshot snapshot = await uploadTask;

                          var imageUrl = await snapshot.ref.getDownloadURL();

                          print("url :   $imageUrl");

                          FirebaseFirestore.instance
                              .collection('Amazon')
                              .doc(id)
                              .set({
                            "Product_name": Product_name.text,
                            "Product_description": Product_description.text,
                            "Product_mrp": int.parse(Product_mrp.text),
                            "image": imageUrl,
                            "Product_price": int.parse(Product_price.text),
                            "product_discount":
                            int.parse(product_discount.text),
                            "Product_brand": Product_brand.text,
                            "Product_color": Product_color.text,
                          }).whenComplete(() {
                            Navigator.pop(context);

                            Navigator.pop(context);
                          });
                        } on FirebaseException catch (e) {
                          print('Error --- ${e.message}');
                          Navigator.pop(context);
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    }

                    // print("id---- $id");
                  },
                  child: Text("Submit",
                    style:
                    TextStyle(fontFamily: "AlumniSansInlineOne"),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
