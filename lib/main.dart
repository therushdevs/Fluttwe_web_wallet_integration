import 'package:flutter/material.dart';
import 'dart:js' as js;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Wallet Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WalletConnector(),
    );
  }
}

class WalletConnector extends StatefulWidget {
  @override
  _WalletConnectorState createState() => _WalletConnectorState();
}

class _WalletConnectorState extends State<WalletConnector> {
  String? account;

  // Function to connect to MetaMask by invoking the JavaScript function
  void _connectMetaMask() async {
    var result = await js.context.callMethod('connectMetaMask');
    setState(() {
      account = result;
    });
  }

  // Function to get the currently selected MetaMask account
  void _getMetaMaskAccount() {
    var result = js.context.callMethod('getMetaMaskAccount');
    setState(() {
      account = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          account != null
              ? Text('Connected MetaMask account: $account')
              : const Text('No MetaMask account connected'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _connectMetaMask,
            child: const Text('Connect to MetaMask'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getMetaMaskAccount,
            child: const Text('Get Current Account'),
          ),
        ],
      ),
    );
  }
}
