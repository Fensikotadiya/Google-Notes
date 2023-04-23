import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notees/dbclass.dart';
import 'package:notees/main.dart';
import 'package:sqflite/sqflite.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabese();
  }

  fordatabese() {
    dbclass().getdb().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  List bgcolor = [
    Colors.red,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.tealAccent,
    Colors.indigo,
    Colors.lightGreen,
    Colors.orange,
    Colors.black87,
    Colors.redAccent,
    Colors.cyan,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.black12,
    Colors.brown,
    Colors.deepPurpleAccent,
    Colors.grey,

  ];
  Color curr = Colors.pink;
  Database? db;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.transparent,
        body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  color: curr,
                  shape:
                  OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topRight: Radius.circular(50))),
                  margin: EdgeInsets.all(30),
                  child: TextFormField(
                    controller: title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: "Content : ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topRight: Radius.circular(50)),
                      ),
                      labelText: "Content:",
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {{
                  showModalBottomSheet(
                      builder: (context) {
                        return Container(
                          child: GridView.builder(
                              itemCount: bgcolor.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      curr = bgcolor[index];
                                    });
                                  },
                                  child: Container(
                                    color: bgcolor[index],
                                  ),
                                );
                              },
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3)),
                        );
                      },
                      context: context);
                };

                },
                child: Container(


                  child: Text("Bacground Color",style: TextStyle(fontSize: 20)),
                ),
              ),

              Expanded(
                flex: 3,
                child: Card(
                  color: Colors.amberAccent.shade200,
                  shape:
                      OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topRight: Radius.circular(50))),
                  margin: EdgeInsets.all(30),
                  child: TextFormField(
                    controller: content,
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                    decoration: InputDecoration(
                      hintText: "Content : ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topRight: Radius.circular(50)),
                      ),
                      labelText: "Content:",
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {

                    int mycolor = curr.value;

                    print("=Color=$mycolor");

                    dbclass()
                        .insertdata(title.text, content.text, db!, mycolor)
                        .then((value) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return notes();
                        },
                      ));
                    });
                  },
                  child: Text("Add Notes (: ",style: TextStyle(fontSize: 20)),)
            ],
          ),
        ),

    );
  }
}
