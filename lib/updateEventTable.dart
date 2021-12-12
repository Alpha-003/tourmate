import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourmate1/entertainmentDataCustomization.dart';
import 'package:tourmate1/eventDataCustomization.dart';

class UpdateEventTable extends StatefulWidget {
  final id;

  const UpdateEventTable({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateEventTable> createState() => _UpdateEventTableState(hId:this.id);
}

class _UpdateEventTableState extends State<UpdateEventTable> {
  final hId;

   _UpdateEventTableState({required this.hId});
var test;
  @override
  void initState() {
    test = FirebaseFirestore.instance
              .collection("Events")
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
            TextEditingController bestDestinationController = TextEditingController(
              text: hotelData[0]["best_destination"],
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
            bool present = hotelData[0]["present"];
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
                            child: Text("Event Name: ",
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
                            child: Text("Best Destination: ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: bestDestinationController,
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
                            child: Text("Location : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: locationController
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
                  value: present,
                  onChanged: (value) {
                    setState(() {
                      present = value!;
                    });
                  },
                ),
                Text(" PRESENT")
              ]);
              }),
                    // 
                    //
                    TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Events')
                              .doc(hId)
                              .update({
                            'best_destination': bestDestinationController.text,
                            'location': locationController.text,
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'district': districtController.text,
                            'type': typeController.text,
                            'image': imageController.text,
                            'present':present
                          });
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDataCustomization()),
                              );
                        },
                        child: Text("Update",style: TextStyle(color: Colors.green),))
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
