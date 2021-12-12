import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourmate1/parkDataCustomization.dart';
import 'package:tourmate1/restaurantDataCustomization.dart';

class UpdateRestaurantTable extends StatefulWidget {
  final id;

  const UpdateRestaurantTable({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateRestaurantTable> createState() => _UpdateRestaurantTableState(hId:this.id);
}

class _UpdateRestaurantTableState extends State<UpdateRestaurantTable> {
  final hId;

   _UpdateRestaurantTableState({required this.hId});
var test;
  @override
  void initState() {
    test = FirebaseFirestore.instance
              .collection("Resturents")
              .where("ID", isEqualTo: hId)
              .snapshots();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Update Data",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
            )),
        body: StreamBuilder(
          stream: test,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List hotelData = [];
            snapshot.data!.docs.map((DocumentSnapshot documet) {
              Map a = documet.data() as Map<String, dynamic>;
              hotelData.add(a);
            }).toList();
            // Controllers
            TextEditingController nameController = TextEditingController(
              text: hotelData[0]["name"],
            );
            TextEditingController contactController = TextEditingController(
              text: hotelData[0]["contact_no"],
            );
            TextEditingController districtController = TextEditingController(
              text: hotelData[0]["district"],
            );
            TextEditingController descriptionController = TextEditingController(
              text: hotelData[0]["description"],
            );
            TextEditingController typeController = TextEditingController(
              text: hotelData[0]["type"],
            );
            TextEditingController locationController = TextEditingController(
              text: hotelData[0]["location"],
            );
            TextEditingController imageController = TextEditingController(
              text: hotelData[0]["image"],
            );
            TextEditingController bestDestinationController = TextEditingController(
              text: hotelData[0]["best_destination"],
            );

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    // first row of name
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Restaurant Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                          ),
                        )
                      ],
                    ),
                    //
                    // 2nd row
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Contact No: ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: contactController,
                            onChanged: (value) {
                              // contactController = value;
                            },
                          ),
                        )
                      ],
                    ),
                    //
                    // 3rd row
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("District : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: districtController,
                          ),
                        )
                      ],
                    ),
                    //
                    //
                    // 4th row
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Description : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: descriptionController,
                          ),
                        )
                      ],
                    ),
                    //
                    //  row
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Image : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: imageController,
                          ),
                        )
                      ],
                    ),
                    //
                    //
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Location : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: locationController,
                          ),
                        )
                      ],
                    ),
                    // 
                    // 
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Best Destination : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: bestDestinationController,
                          ),
                        )
                      ],
                    ),
                    // 
                    // 

                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Type : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: typeController,
                          ),
                        )
                      ],
                    ),
                    // 
                    //
                    TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Parks')
                              .doc(hId)
                              .update({
                            'contact_no': contactController.text,
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'type': typeController.text,
                            'location': locationController.text,
                            'image': imageController.text,
                            'district':districtController.text,
                            'best_destination': bestDestinationController.text
                          });
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestaurantDataCustomization()),
                              );
                        },
                        child: Text("Update"))
                  ],
                ),
              ),
            );
          },
         
        ),
      ),
    );

  }
   
}
