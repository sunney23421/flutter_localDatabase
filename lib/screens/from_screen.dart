import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
//get text value

//controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Information Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name List"),
                  autofocus: true,
                  controller: titleController,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return "It's empty lol put something";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (str) {
                    if (str!.isEmpty) {
                      return "It's empty lol put number";
                    }
                    if (double.parse(str) <= 0) {
                      return "price must more that 0";
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      //prepar data
                      Transactions statement = Transactions(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      //call provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.pop(context);
                    }
                  },

                  
                  child: const Text("Add Data"),
                  style: TextButton.styleFrom(
                      primary: Colors.green, backgroundColor: Colors.black),
                )
              ],
            ),
          ),
        ));
  }
}
