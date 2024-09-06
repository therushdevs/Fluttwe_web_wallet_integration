import 'package:flutter/material.dart';
import 'package:web_wallet_integration/features/wallet_integration/presentation/metamask_wallet.dart';
import 'package:web_wallet_integration/features/wallet_integration/presentation/phantom_wallet.dart';
import 'package:web_wallet_integration/features/wallet_integration/presentation/trust_wallet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(38.0),
              child: Text(
                "Wallet Integration",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MetamaskWallet()));
                },
                child: const Text(
                  "Metamask Integration",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PhantomWallet()));
                },
                child: const Text(
                  "Phantom Integration",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TrustWallet()));
                },
                child: const Text(
                  "Trustwallet Integration",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
