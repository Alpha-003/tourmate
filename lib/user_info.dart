import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

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
              "Booking confirmed users",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
            )),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("user_detail_for_booking").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List userInfoList = [];
            snapshot.data!.docs.map((DocumentSnapshot documet) {
              Map a = documet.data() as Map<String, dynamic>;
              userInfoList.add(a);
            }).toList();
            return Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: 1,
                  columns: [
                    DataColumn(label: Text("F.Name")),
                    DataColumn(label: Text("L.Name")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Contact")), 
                    DataColumn(label: Text("Price")), 
                    DataColumn(label: Text("Rooms")), 
                    DataColumn(label: Text("Room Name")), 
                  ],
                  rows: <DataRow>[
 for(var i =0;i<userInfoList.length;i++)...[
                     DataRow(cells: [
                      DataCell(Text(userInfoList[i]["first_name"])),
                      DataCell(Text(userInfoList[i]["last_name"])),
                      DataCell(Text(userInfoList[i]["email"])),
                      DataCell(Text(userInfoList[i]["contact_no"])),
                      DataCell(Text("${userInfoList[i]["price"]}")),
                      DataCell(Text("${userInfoList[i]["rooms"]}")),
                      DataCell(Text("${userInfoList[i]["room_name"]}")),
                    ])
 ]
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

