import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'package:web_wallet_integration/core/utils/assetPaths/asset_paths.dart';
import 'package:web_wallet_integration/core/utils/error_handling/error_messages.dart';

import '../../../core/utils/toasts.dart';

class PhantomWallet extends StatefulWidget {
  const PhantomWallet({super.key});

  @override
  State<PhantomWallet> createState() => _PhantomWalletState();
}

class _PhantomWalletState extends State<PhantomWallet> {
  String? publicKey;
  bool? isPhantomInstalled = false;

  @override
  void initState() {
    super.initState();
    checkIfPhantomInstalled();
  }

  // Check if Phantom is installed
  void checkIfPhantomInstalled() {
    isPhantomInstalled = js.context.callMethod('isPhantomInstalled') ?? false;
    setState(() {});
  }

  // Connect to Phantom wallet
  void connectPhantomWallet() async {
    if (isPhantomInstalled == true) {
      var result = await js_util
          .promiseToFuture(js.context.callMethod('connectPhantom'));
      if (result is String) {
        setState(() {
          publicKey = result;
        });
      } else {
        showWarningToast(warningMessage: ErrorMessages.ErrorConnectingPhantom);
      }
    } else {
      showWarningToast(warningMessage: ErrorMessages.PhantomNotInstalled);
    }
  }

  // Get the currently connected public key
  void getConnectedPublicKey() {
    try {
      var result = js.context.callMethod('getPhantomPublicKey');
      if (result is String) {
        setState(() {
          publicKey = result;
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
          'Phantom Wallet Integration',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AssetPaths.pngAssets.phantomImagePath,
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
              child: isPhantomInstalled == true
                  ? publicKey != null
                      ? Text(
                          'Connected public key: $publicKey',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      : const SizedBox()
                  : const Text(
                      'Phantom Wallet is not installed',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: connectPhantomWallet,
              child: const Text('Connect Phantom Wallet'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getConnectedPublicKey,
              child: const Text('Get Connected Public Key'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
