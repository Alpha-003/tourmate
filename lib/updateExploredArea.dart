import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateExploredAreasTable extends StatefulWidget {
  final id;

  const UpdateExploredAreasTable({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateExploredAreasTable> createState() =>
      _UpdateExploredAreasTableState(hId: this.id);
}

class _UpdateExploredAreasTableState extends State<UpdateExploredAreasTable> {
  final hId;

  _UpdateExploredAreasTableState({required this.hId});
  var test;
  @override
  void initState() {
    test = FirebaseFirestore.instance
        .collection("Areas")
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
              "Update Areas Data",
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
            TextEditingController locationController = TextEditingController(
              text: hotelData[0]["location"],
            );
            TextEditingController bestDestinationController =
                TextEditingController(
              text: hotelData[0]["best_destination"],
            );
            bool exploredArea = hotelData[0]["explored_area"];
            bool historicalArea = hotelData[0]["historical"];
            bool hikingAndTracking = hotelData[0]["hiking_and_tracking"];
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
                            child: Text("Area Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                          ),
                        )
                      ],
                    ),
                    //
                    //
                    //  row
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

                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          Row(children: [
                            Checkbox(
                              value: historicalArea,
                              onChanged: (value) {
                                setState(() {
                                  historicalArea = value!;
                                });
                              },
                            ),
                            Text("Historical Area")
                          ]),
                          Row(children: [
                            Checkbox(
                              value: hikingAndTracking,
                              onChanged: (value) {
                                setState(() {
                                  hikingAndTracking = value!;
                                });
                              },
                            ),
                            Text("Hiking and Tracking")
                          ]),
                          Row(children: [
                            Checkbox(
                              value: exploredArea,
                              onChanged: (value) {
                                setState(() {
                                  exploredArea = value!;
                                });
                              },
                            ),
                            Text("Explored Area")
                          ])
                        ],
                      );
                    }),

                    //
                    //
                    TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Areas')
                              .doc(hId)
                              .update({
                            'location': locationController.text,
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'type': typeController.text,
                            'image': imageController.text,
                            'best_destination': bestDestinationController.text,
                            'explored_area': exploredArea,
                            'hiking_and_tracking': hikingAndTracking,
                            'historical': historicalArea
                          });
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.green),
                        ))
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
