import 'dart:convert';
import 'dart:js_util' as js_util;
import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:web_wallet_integration/core/utils/assetPaths/asset_paths.dart';
import 'package:web_wallet_integration/core/utils/error_handling/error_messages.dart';
import 'package:web_wallet_integration/core/utils/toasts.dart';

class MetamaskWallet extends StatefulWidget {
  const MetamaskWallet({super.key});

  @override
  State<MetamaskWallet> createState() => _MetamaskWalletState();
}

class _MetamaskWalletState extends State<MetamaskWallet> {
  var account;
  bool? isMetamaskInstalled = false;

  @override
  void initState() {
    super.initState();
    checkIfMetamaskInstalled();
  }

  // Check if Phantom is installed
  void checkIfMetamaskInstalled() {
    isMetamaskInstalled = js.context.callMethod('isMetaMaskInstalled') ?? false;
    if (!(isMetamaskInstalled ?? false)) {
      showWarningToast(warningMessage: ErrorMessages.MetamaskNotInstalled);
    }
    setState(() {});
  }

  // Function to connect to MetaMask by invoking the JavaScript function
  void _connectMetaMask() async {
    if (isMetamaskInstalled == true) {
      var result = await js.context.callMethod('connectMetaMask');
      if (result is String) {
        setState(() {
          account = result;
        });
      } else {
        showWarningToast(warningMessage: "Error: ${result}");
      }
    } else {
      showWarningToast(warningMessage: ErrorMessages.MetamaskNotInstalled);
    }
  }

  // Function to get the currently selected MetaMask account
  void _getMetaMaskAccount() {
    try {
      var result = js.context.callMethod('getMetaMaskAccount');
      if (result is String) {
        setState(() {
          account = result;
        });
      } else {
        showWarningToast(warningMessage: result.toString());
      }
    } catch (err) {
      showWarningToast(warningMessage: "$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metamask Wallet Integration',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPaths.pngAssets.metamaskImagePath,
              height: 200,
              width: 200,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isMetamaskInstalled == true
                  ? account != null
                      ? Text(
                          'Connected MetaMask account: $account',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      : const SizedBox()
                  : const Text(
                      'Metamask Wallet is not installed',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
            ),
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
      ),
    );
  }
}
