import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourmate1/transportDataCustomization.dart';

class UpdateTransportTable extends StatefulWidget {
  final id;

  const UpdateTransportTable({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateTransportTable> createState() => _UpdateTransportTableState(hId:this.id);
}

class _UpdateTransportTableState extends State<UpdateTransportTable> {
  final hId;

   _UpdateTransportTableState({required this.hId});
var test;
  @override
  void initState() {
    test = FirebaseFirestore.instance
              .collection("Transport")
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
              "Update Transport Data",
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
            TextEditingController vehidController = TextEditingController(
              text: hotelData[0]["Veh_id"],
            );
            TextEditingController companyController = TextEditingController(
              text: hotelData[0]["company"],
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
            TextEditingController imageController = TextEditingController(
              text: hotelData[0]["image"],
            );
            TextEditingController locationController = TextEditingController(
              text: hotelData[0]["location"],
            );
            bool topHotel = hotelData[0]["local"];
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
                            child: Text("Transport Name: ",
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
                    // 3rd row
                    Row(
                      children: [
                        Container(
                            width: 100,
                            child: Text("Company : ",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                          child: TextFormField(
                            controller: companyController,
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
                            'Veh_id': vehidController.text,
                            'company': companyController.text,
                            'contact_no': contactController.text,
                            'location': locationController.text,
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'type': typeController.text,
                            'image': imageController.text,
                            'top_hotel':topHotel
                          });
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransportDataCustomization()),
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
