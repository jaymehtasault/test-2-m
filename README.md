# modern_banking_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Use of Ai:

Used chatgpt for this code but i have edited the code as per my web need and took refrence from the ai but thinked and implemented by myself 

class TransactionScreen extends StatelessWidget {
  final String accountName;
  final List<dynamic> transactions;
  TransactionScreen({required this.accountName, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$accountName Transactions')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          bool isExpense = tx['amount'] < 0;
