import 'package:flutter/material.dart';
import 'package:budgeting_app/transaction.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> with SingleTickerProviderStateMixin {
  final List<Transaction> _transactions = [];
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;

  late final TabController _tabController;
  final List<Tab> _tabs = [
    Tab(text: '支出'),
    Tab(text: '収入'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: enteredTitle,
      amount: enteredAmount,
      dateTime: DateTime.now(),
      type: _selectedType,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: kToolbarHeight - 16.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.blue,
                tabs: _tabs,
              ),
            ),
          ),
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
      ),
    );
  }
}
