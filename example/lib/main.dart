import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Paystack Max',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Paystack Max'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool initializingPayment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      //
      body: Center(
        child: initializingPayment
            ? const CircularProgressIndicator.adaptive()

            //
            : OutlinedButton(
                onPressed: makePayment,
                child: const Text('Make Payment'),
              ),
      ),
    );
  }

  void makePayment() async {
    const secretKey = '...';

    final request = PaystackTransactionRequest(
      reference: 'ps_${DateTime.now().microsecondsSinceEpoch}',
      secretKey: secretKey,
      email: 'test@mail.com',
      amount: 15 * 100,
      currency: PaystackCurrency.ngn,
      channel: [
        PaystackPaymentChannel.mobileMoney,
        PaystackPaymentChannel.card,
        PaystackPaymentChannel.ussd,
        PaystackPaymentChannel.bankTransfer,
        PaystackPaymentChannel.bank,
        PaystackPaymentChannel.qr,
        PaystackPaymentChannel.eft,
      ],
    );

    setState(() => initializingPayment = true);
    final initializedTransaction =
        await PaymentService.initializeTransaction(request);

    if (!mounted) return;
    setState(() => initializingPayment = false);

    if (!initializedTransaction.status) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(initializedTransaction.message),
      ));

      return;
    }

    await PaymentService.showPaymentModal(
      context,
      transaction: initializedTransaction,
    );

    final response = await PaymentService.verifyTransaction(
      paystackSecretKey: secretKey,
      initializedTransaction.data?.reference ?? request.reference,
    );

    if (kDebugMode) Logger().i(response.toMap());
  }
}
