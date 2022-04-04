import 'dart:io';

import 'package:flutter_database/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter_database/providers/transaction_provider.dart';

class TransctionDB {
  //service about database,use ,retive

  String dbName; //Name of databsse
  //if no datebse, make one
  //if have database, use it, open
  TransctionDB({required this.dbName});

  Future<Database> openDatebase() async {
    //to to user path of dbName, it's string like /users/name
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    //make database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //insertData
  Future<int> insertData(Transactions statement) async {
    //store
    // transction.db => expense
    var db = await openDatebase();
    var store = intMapStoreFactory.store("expense");

    //json
    var keyId = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });
    db.close();
    return keyId; //1,2,3,4...
  }

  //use db
  Future<List> loadAllData() async {
    var db = await openDatebase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    List transactionList = <Transactions>[];
    for (var record in snapshot) {
      transactionList.add(
        Transactions(
          title: record["title"] as String,
          amount: record["amount"] as double,
          date: DateTime.parse(record["date"] as dynamic),
        ),
      );
    }
    print(transactionList.toString());
    return transactionList;
  }

  Future lol() async {
    
    print(TransactionProvider().getTransaction());
  }
}
