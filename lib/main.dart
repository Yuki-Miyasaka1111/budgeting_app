import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('家計簿アプリ')),
        body: MyHomePage(),
      ),
    );
  }
}

class Expense {
  final String title;
  final int amount;

  Expense({required this.title, required this.amount});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Expense> expenses = [];

  void _addExpense(String title, int amount) {
    setState(() {
      expenses.add(Expense(title: title, amount: amount));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ExpenseList(expenses: expenses)),
        AddExpense(onAddExpense: _addExpense),
      ],
    );
  }
}

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseList({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(expenses[index].title),
          trailing: Text('${expenses[index].amount}円'),
        );
      },
    );
  }
}

class AddExpense extends StatefulWidget {
  final Function(String, int) onAddExpense;

  AddExpense({required this.onAddExpense});

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: '金額'),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final amount = int.tryParse(amountController.text) ?? 0;
              if (title.isNotEmpty && amount > 0) {
                widget.onAddExpense(title, amount);
                titleController.clear();
                amountController.clear();
              }
            },
            child: Text('追加'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }
}