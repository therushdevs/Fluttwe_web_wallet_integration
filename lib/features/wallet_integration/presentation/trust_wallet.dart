import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:web_wallet_integration/core/utils/assetPaths/asset_paths.dart';

import '../../../core/utils/error_handling/error_messages.dart';
import '../../../core/utils/toasts.dart';

class TrustWallet extends StatefulWidget {
  const TrustWallet({super.key});

  @override
  State<TrustWallet> createState() => _TrustWalletState();
}

class _TrustWalletState extends State<TrustWallet> {
  String? walletAddress;
  bool? isTrustWalletInstalled = false;

  @override
  void initState() {
    super.initState();
    checkIfTrustWalletInstalled();
  }

  // Check if Phantom is installed
  void checkIfTrustWalletInstalled() {
    isTrustWalletInstalled =
        js.context.callMethod('isTrustWalletInstalled') ?? false;
    setState(() {});
  }

  // Function to connect Trust Wallet via WalletConnect
  void _connectTrustWallet() async {
    try {
      await js.context.callMethod('connectTrustWallet');
    } catch (error) {
      print('Error: $error');
      showWarningToast(
          warningMessage: ErrorMessages.ErrorConnectingTrustWallet);
    }
  }

  // Function to get the connected wallet's address
  void _getConnectedAccount() {
    try {
      var address = js.context.callMethod('getConnectedAccount');
      if (address is String) {
        setState(() {
          walletAddress = address;
        });
      } else {
        showWarningToast(warningMessage: address.toString());
      }
    } catch (err) {
      showWarningToast(warningMessage: "$err");
    }
  }

  // Function to disconnect the wallet
  // void _disconnectWallet() {
  //   js.context.callMethod('disconnectTrustWallet');
  //   setState(() {
  //     walletAddress = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trust Wallet Integration',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AssetPaths.pngAssets.trustWalletImagePath),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isTrustWalletInstalled == true
                  ? walletAddress != null
                      ? Text(
                          'Connected Trust Wallet Address: $walletAddress',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      : const SizedBox()
                  : const Text(
                      'Trust Wallet is not installed',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _connectTrustWallet,
              child: const Text('Connect Trust Wallet'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getConnectedAccount,
              child: const Text('Get Wallet Address'),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _disconnectWallet,
            //   child: const Text('Disconnect Wallet'),
            // ),
          ],
        ),
      ),
    );
  }
}
