import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBank App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String bankLogo = 'assets/bank_logo.png'; // Ensure you have this asset in your project

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.green.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(bankLogo, width: 100, height: 100),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to MyBank!',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900),
                    ),
                    SizedBox(height: 10),
                    Text('Today is $today',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AccountListScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text('Show Accounts', style: TextStyle(fontSize: 18)),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountListScreen extends StatelessWidget {
  final Map<String, dynamic> accountsJson = jsonDecode('''
  {
     "transactions": {
    "Chequing": [
      {"date": "2025-01-05", "description": "Grocery Shopping", "amount": -85.50},
      {"date": "2025-01-07", "description": "Salary Deposit", "amount": 2500.00},
      {"date": "2025-01-10", "description": "Coffee Shop", "amount": -12.75},
      {"date": "2025-01-12", "description": "Gym Membership", "amount": -50.00}
    ],
    "Savings": [
      {"date": "2025-01-01", "description": "Initial Deposit", "amount": 1000.00},
      {"date": "2025-01-08", "description": "Interest", "amount": 15.25},
      {"date": "2025-01-10", "description": "Transfer to Chequing", "amount": -200.00},
      {"date": "2025-01-15", "description": "Bonus Deposit", "amount": 500.00}
    ]
  }
}
''');

  @override
  Widget build(BuildContext context) {
    final accounts = accountsJson['transactions'].keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Accounts'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          String account = accounts[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TransactionScreen(
                                    accountName: account,
                                    transactions:
                                        accountsJson['transactions'][account])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text('View Transactions'),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green.shade700),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isExpense ? Colors.red[100] : Colors.green[100],
                child: Icon(isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isExpense ? Colors.red : Colors.green),
              ),
              title: Text(tx['description'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(tx['date']),
              trailing: Text('\$${tx['amount'].toStringAsFixed(2)}',
                  style: TextStyle(
                      color: isExpense ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}