
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbclass  {

   Future<Database> getdb() async {
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'demo11.db');
        // open the database
        Database database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
                // When creating the db, create the table
                await db.execute(
                    'create table note (ID integer primary key autoincrement,TITLE text,CONTENT text,COLOR integer)'
                );
            });
        return database;
    }

    Future<void> insertdata(String titel, String content, Database db, int curr) async {
     String insert="insert into note(TITLE,CONTENT,COLOR) values('$titel','$content','$curr')";
     int aa =await db.rawInsert(insert);
     print("==================$aa");
    }

  Future<List<Map>> viewdata(Database db) async {
    String view= "select * from note ";
    List<Map> listdata = await db.rawQuery(view);
    print("===$listdata");
    return listdata;
  }

  Future<void> delete(Database db, int idd) async {
    String Dd = "Delete from contact where ID='$idd'";
    int aa = await db.rawDelete(Dd);
  }

  Future<void>updatedata(String newtitle, String newcontent, Database db, int mycolor, int iddd) async {
    String dd="update note set TITLE='$newtitle',CONTENT='$newcontent' where ID='$iddd' ";
    int aa=await db.rawUpdate(dd);

  }



}


