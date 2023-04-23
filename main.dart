import 'package:flutter/material.dart';
import 'package:notees/addnote.dart';
import 'package:notees/dbclass.dart';
import 'package:notees/update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: notes(),
  ));
}

class notes extends StatefulWidget {
  static SharedPreferences? preferences;

  const notes({Key? key}) : super(key: key);

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forviewdb();
  }

  forviewdb() {
    dbclass().getdb().then((value) {
      setState(() {
        db = value;
      });
      dbclass().viewdata(db!).then((value1) {
        setState(() {
          notedata = value1;
        });
      });
    });
  }

  List<Map> notedata = [];
  Database? db;

  Color current = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Card(
        child: Text("Notes", style: TextStyle(fontSize: 30)),
      )),
      body: Container(
        child: GridView.builder(
            itemCount: notedata.length,
            itemBuilder: (context, index) {
              int ss = notedata[index]['COLOR'];
              print("=ss==$ss");
              return Card(
                color: Color(ss),
                shadowColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                margin: EdgeInsets.all(15),
                elevation: 20,
                child: ListTile(
                  trailing: PopupMenuButton(onSelected: (value) {
                    if (value == 1) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return update(notedata[index]);
                        },
                      ));
                    }
                  }, itemBuilder: (context) {
                    return [
                      PopupMenuItem(value: 1, child: Text("Update")),
                      PopupMenuItem(
                          value: 2,
                          onTap: () {
                            int idd = notedata[index]['id'];
                            dbclass().delete(db!, idd).then((value) {
                              return forviewdb();
                            });
                          },
                          child: Text("Delete"))
                    ];
                  }),
                  subtitle: Text("${notedata[index]['TITLE']}"),
                  title: Text("${notedata[index]['CONTENT']}"),
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return addnote();
            },
          ));
        },
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
