A Flutter package for making payments via Paystack Payment Gateway (https://paystack.com)

<p align="center">
  <a href="https://pub.dev/packages/flutter_paystack_max"><img src="https://img.shields.io/pub/v/flutter_paystack_max.svg" alt="pub.dev"></a>
  <a href="https://pub.dev/packages/flutter_paystack_max/score"><img src="https://img.shields.io/pub/likes/flutter_paystack_max" alt="likes"></a>
  <a href="https://pub.dev/packages/flutter_paystack_max/score"><img src="https://img.shields.io/pub/popularity/flutter_paystack_max" alt="popularity"></a>
  <a href="https://pub.dev/packages/flutter_paystack_max/score"><img src="https://img.shields.io/pub/points/flutter_paystack_max" alt="pub points"></a>
</p>

<p align="center">
   <img src="https://github.com/binemmanuel/flutter_paystack_max/blob/main/assets/gifs/payment-with-card.gif?raw=true" width="200" alt="Pay with card">
  <img src="https://github.com/binemmanuel/flutter_paystack_max/blob/main/assets/gifs/payment-with-mobile-money.gif?raw=true" width="200" alt="Pay with mobile money">
</p>

## Features

:heavy_check_mark: All Paystack supported payment methods/channels

-   Mobile Money
-   Card
-   USSD
-   Bank Transfer
-   Bank
-   QR
-   EFT

:heavy_check_mark: Verifying Transactions

## Supported Platforms

-   Android and
-   iOS

## Prerequisites

-   Paystack secret key
-   Callback URL

No configuration required for this package works out of the box.

## Usage

1. Create a transaction request object.

```dart
final request = PaystackTransactionRequest(
    reference: '...',
    secretKey: '....',
    email: '...',
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
```

2. Initialize the transaction with the above transaction request.

```dart
final initializedTransaction = await PaymentService.initializeTransaction(request);

if (!initializedTransaction.status) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(initializedTransaction.message),
    ));

    return;
}
```

3. Open the payment modal to accept payment

```dart
final response = await PaymentService.showPaymentModal(
    context,
    transaction: initializedTransaction,
    // Callback URL must match the one specified on your paystack dashboard,
    callbackUrl: '...'
).then((_) async {
    return await PaymentService.verifyTransaction(
        paystackSecretKey: '...',
        initializedTransaction.data?.reference ?? request.reference,
    );
});

print(response); // Result of the confirmed payment
```

## Additional information

Visit the paystack documentation for more information https://paystack.com/docs/api/transaction

## :pencil: Contributing, :disappointed: Issues and :bug: Bug Reports

This project is open to contributions. </br>
Please feel very free to help improve the payment experience on Flutter. </br>
Experienced an issue or want to report a bug? Please, [report it here](https://github.com/binemmanuel/flutter_paystack_max/issues).
