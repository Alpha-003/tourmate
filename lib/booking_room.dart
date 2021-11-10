import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoomBooking extends StatefulWidget {
  const RoomBooking({Key? key}) : super(key: key);

  @override
  State<RoomBooking> createState() => _RoomBookingState();
}

class _RoomBookingState extends State<RoomBooking> {
  var childrens = 0;
  var adults = 1;
  var rooms = 1;
  var testroom = '';
  var testadults = '';
  var testchilds = '';
  void _onbottompressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return Container(
              height: MediaQuery.of(context).size.height / 2 - 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(children: <Widget>[
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 1,
                  ),
                  Row(children: [
                    SizedBox(width: 200, child: Text("Adults")),
                    Expanded(child: Center()),
                    TextButton(
                        onPressed: () {
                          if (adults > 1) {
                            setState1(() {
                              adults--;
                              testadults = adults.toString();
                              adultsText();
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                        child: Text("$adults")),
                    TextButton(
                        onPressed: () {
                          if (adults < 20) {
                            setState1(() {
                              adults++;
                              testadults = adults.toString();
                              adultsText();
                            });
                          }
                        },
                        child: Icon(Icons.add))
                  ]),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 1,
                  ),
                  Row(children: [
                    SizedBox(width: 200, child: Text("Childrens")),
                    Expanded(child: Center()),
                    TextButton(
                        onPressed: () {
                          if (childrens > 0) {
                            setState1(() {
                              childrens--;
                              testchilds = childrens.toString();
                              childText();
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                        child: Text("$childrens")),
                    TextButton(
                        onPressed: () {
                          if (childrens < 30) {
                            setState1(() {
                              childrens++;
                              testchilds = childrens.toString();
                              childText();
                            });
                          }
                        },
                        child: Icon(Icons.add))
                  ]),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 1,
                  ),
                  Row(children: [
                    SizedBox(width: 200, child: Text("Rooms")),
                    Expanded(child: Center()),
                    TextButton(
                        onPressed: () {
                          if (rooms > 1) {
                            setState1(() {
                              rooms--;
                              testroom = rooms.toString();
                              roomsText();
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                        child: Text("$rooms")),
                    TextButton(
                        onPressed: () {
                          if (rooms < 10) {
                            setState1(() {
                              rooms++;
                              testroom = rooms.toString();
                              roomsText();
                            });
                          }
                        },
                        child: Icon(Icons.add))
                  ]),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 1,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Apply", style: TextStyle(color: Colors.black)),
                    color: Colors.blue[800],
                    height: 60,
                    minWidth: double.infinity,
                  )
                ]),
              ),
            );
          });
        });
  }

  String roomsText() {
    setState(() {
      testroom = rooms.toString();
    });
    return testroom;
  }

  String adultsText() {
    setState(() {
      testadults = adults.toString();
    });
    return testadults;
  }

  String childText() {
    setState(() {
      testchilds = childrens.toString();
    });
    return testchilds;
  }

  final DateRangePickerController _controller = DateRangePickerController();
  String test = '';
  String test1 = '';
  bool checkBoxValue = false;

  String fromDate =
      DateFormat('E,MMMM dd, yyyy').format(DateTime.now()).toString();
  String toDate = DateFormat('E,MMMM dd, yyyy')
      .format(DateTime.now().add(Duration(days: 1)))
      .toString();
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      fromDate =
          DateFormat('E,MMMM dd, yyyy').format(args.value.startDate).toString();
      test =
          DateFormat('E,MMMM dd, yyyy').format(args.value.startDate).toString();
      toDate =
          DateFormat('E,MMMM dd, yyyy').format(args.value.endDate).toString();
      test1 =
          DateFormat('E,MMMM dd, yyyy').format(args.value.endDate).toString();
      setState(() {});
    });
  }

  Future _sellectionDateRange(BuildContext context) async {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return Card(
            margin: const EdgeInsets.fromLTRB(40, 100, 50, 40),
            child: SfDateRangePicker(
              controller: _controller,
              backgroundColor: Colors.white,
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              // allowViewNavigation: ,
              onSubmit: (Object value) {
                Navigator.pop(context);
              },
              onSelectionChanged: selectionChanged,
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              )),
          title: Text(
            "Booking",
            style: GoogleFonts.roboto(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [],
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.yellowAccent[700],
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GestureDetector(
                          onTap: () => _sellectionDateRange(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text("Check-In-Date",
                                        style: TextStyle(fontSize: 14)),
                                    Text(
                                      fromDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text(
                                      "Check-Out-Date",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      toDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: GestureDetector(
                          onTap: () {
                            // showAlertDialog(context);
                            _onbottompressed();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 14,
                                color: Colors.white,
                                child: Column(
                                  children: [Text("Adults"), Text("$adults")],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 14,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text("Children"),
                                    Text("$childrens")
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 14,
                                color: Colors.white,
                                child: Column(
                                  children: [Text("Rooms"), Text(roomsText(),style: TextStyle(fontWeight: FontWeight.bold),)],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: checkBoxValue,
                                    onChanged: (value) {
                                      setState(() {
                                        this.checkBoxValue = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.5),
                                  child: Text("I'm travelling for work",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            child: MaterialButton(
                          onPressed: () {},
                          child: Text("Search",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          color: Colors.blue[800],
                          height: 60,
                          minWidth: double.infinity,
                        )),
                      )
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
