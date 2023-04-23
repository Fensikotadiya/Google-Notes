import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'dbclass.dart';
import 'main.dart';

class update extends StatefulWidget {
  Map notedata;

  @override
  State<update> createState() => _updateState();

  update(Map this.notedata);
}
TextEditingController newtitle = TextEditingController();
TextEditingController newcontent = TextEditingController();
Color curr = Colors.pink;
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
  Colors.pinkAccent.shade700
];
Database? db;
List<Map> notedata = [];
class _updateState extends State<update> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabese();
    newtitle.text = widget.notedata['TITLE'];
    newcontent.text = widget.notedata['CONTENT'];
  }
  void fordatabese() {
    dbclass().getdb().then((value) {
      setState(() {
        db = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              color: curr,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              margin: EdgeInsets.all(30),
              child: TextFormField(
                controller: newtitle,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  hintText: "Content : ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  labelText: "Content:",
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              {
                showModalBottomSheet(
                    builder: (context) {
                      return Container(
                        child: GridView.builder(

                            itemCount: bgcolor.length,
                            itemBuilder: (context, index) {
                             // int ss = notedata[index]['COLOR'];
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
              }
              ;
            },
            child: Container(
              child: Text("Bacground Color", style: TextStyle(fontSize: 20)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              color: Colors.amberAccent.shade200,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              margin: EdgeInsets.all(30),
              child: TextFormField(
                controller: newcontent,
                style: TextStyle(color: Colors.black87, fontSize: 25),
                decoration: InputDecoration(
                  hintText: "Content : ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
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
              int iddd = widget.notedata['ID'];
              dbclass().updatedata(newtitle.text, newcontent.text, db!, mycolor,iddd).then((value) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return notes();
                  },
                ));
              });
            },
            child: Text("Update"
                " ", style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
