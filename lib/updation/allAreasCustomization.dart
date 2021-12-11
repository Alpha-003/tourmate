import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourmate1/Data%20Entry%20Firestore/areas_data.dart';
import 'package:tourmate1/updation/updateAreasTable.dart';
import 'package:tourmate1/updation/updateExploredArea.dart';

class AllAreasData extends StatefulWidget {
  const AllAreasData({Key? key}) : super(key: key);

  @override
  State<AllAreasData> createState() => _AllAreasDataState();
}

class _AllAreasDataState extends State<AllAreasData> {
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
            "All Areas Data",
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
          ),
          actions: [
            // ignore: deprecated_member_use
            OutlineButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AreasData()));
              },
              child: Text("Insert New"),
              splashColor: Colors.white,
              //color: Colors.transparent,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Areas").snapshots(),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    // columnSpacing: 2,
                    // sortColumnIndex: 1,
                    columns: [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("Description")),
                      DataColumn(label: Text("district")),
                      DataColumn(label: Text("image")),
                      DataColumn(label: Text("location")),
                      DataColumn(label: Text("name")),
                      DataColumn(label: Text("Best Destination")),
                      DataColumn(label: Text("type")),
                      DataColumn(label: Text("Delete Doc")),
                      DataColumn(label: Text("Update Doc")),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < userInfoList.length; i++) ...[
                        DataRow(cells: [
                          DataCell(Text(userInfoList[i]["ID"])),
                          DataCell(SingleChildScrollView(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: 200,
                                  child:
                                      Text(userInfoList[i]["description"])))),
                          DataCell(Text("${userInfoList[i]["district"]}")),
                          DataCell(SingleChildScrollView(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: 200,
                                  child: Text(userInfoList[i]["image"])))),
                          DataCell(Text("${userInfoList[i]["location"]}")),
                          DataCell(Text("${userInfoList[i]["name"]}")),
                          DataCell(
                              Text("${userInfoList[i]["best_destination"]}")),
                          DataCell(Text("${userInfoList[i]["type"]}")),
                          DataCell(TextButton(
                            child: Text(
                              "delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              showAlertDialog(BuildContext context) {
                                Widget cancelButton = TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("cancel"));
                                Widget continueButton = TextButton(
                                  child: Text("Continue"),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Areas")
                                        .doc(userInfoList[i]["ID"])
                                        .delete();
                                    Navigator.pop(context);
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: Text("Alert Dialog"),
                                  content:
                                      Text("Are you sure you want to delete"),
                                  actions: [cancelButton, continueButton],
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    });
                              }

                              showAlertDialog(context);
                            },
                          )),
                          DataCell(TextButton(
                            child: Text(
                              "update",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              if (userInfoList[i]["best_destination"] == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateAreasTable(
                                            id: userInfoList[i]["ID"],
                                          )),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateExploredAreasTable(
                                            id: userInfoList[i]["ID"],
                                          )),
                                );
                              }
                            },
                          )),
                        ])
                      ]
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
