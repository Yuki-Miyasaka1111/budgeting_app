import 'package:flutter/material.dart';
import 'package:budgeting_app/transaction.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final List<Transaction> _transactions = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _addTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    final newTransaction = Transaction(
      title: enteredTitle,
      amount: enteredAmount,
      dateTime: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('家計簿アプリ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'タイトル'),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: '金額'),
            keyboardType: TextInputType.number,
          ),
          TextButton(
            child: Text('追加'),
            style: TextButton.styleFrom(primary: Colors.purple),
            onPressed: _addTransaction,
          ),
          Column(
            children: _transactions.map((transaction) {
              return Card(
                child: ListTile(
                  title: Text(
                    transaction.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${transaction.amount}円',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}