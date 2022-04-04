import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:sembast/sembast.dart';

class TransactionProvider with ChangeNotifier {
  //This is Ptovider>>
  List transactions = [
    //Transaction(title: "Book", amount: 500, date: DateTime.now()),
  ];
  // pull date
  List getTransaction() {
    return transactions;
  }

  //show data when apps start
  void initDate() async {
    var db = TransctionDB(dbName: "transaction.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }

  //add data
  void addTransaction(Transactions statement) async {
    var db = TransctionDB(dbName: "transaction.db");
    //put data into database
    await db.insertData(statement);
    //use it
    transactions = await db.loadAllData();

    //path for keep db
    //transactions.insert(0, statement);
    //nontifi consumer
    notifyListeners();
  }

  void delTransaction(Transactions statement) async {
    var db = TransctionDB(dbName: "transaction.db");
    //put data into database
    final index = Finder(filter: Filter.byKey(Field.key));
    // await db.delete(
    // db,
    //  Finder(index),

    // );

    //use it
    transactions = await db.loadAllData();

    notifyListeners();
  }

  void dele2Transaction() {
    //print();
  }
}
