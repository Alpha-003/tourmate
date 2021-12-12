import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourmate1/hotelsData_customization.dart';

class UpdateTable extends StatefulWidget {
  final id;

  const UpdateTable({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateTable> createState() => _UpdateTableState(hId:this.id);
}

class _UpdateTableState extends State<UpdateTable> {
  final hId;

   _UpdateTableState({required this.hId});
var test;
  @override
  void initState() {
    test = FirebaseFirestore.instance
              .collection("hotel")
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
            TextEditingController priceController = TextEditingController(
              text: hotelData[0]["price"],
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
            TextEditingController imageController = TextEditingController(
              text: hotelData[0]["image"],
            );
            bool topHotel = hotelData[0]["top_hotel"];
            //

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
                            child: Text("Hotel Name: ",
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
                    // price
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Price : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
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
                     StatefulBuilder(builder: (BuildContext context,StateSetter setState){
                return Row(children: [
                Checkbox(
                  value: topHotel,
                  onChanged: (value) {
                    setState(() {
                      topHotel = value!;
                    });
                  },
                ),
                Text("Local")
              ]);
              }),
                    // 
                    //
                    TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('hotel')
                              .doc(hId)
                              .update({
                            'contact_no': contactController.text,
                            'price': priceController.text,
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'district': districtController.text,
                            'type': typeController.text,
                            'image': imageController.text,
                            'top_hotel':topHotel
                          });
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotelDataCustomization()),
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
