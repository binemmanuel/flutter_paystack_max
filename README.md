A Flutter package for making payments via Paystack Payment Gateway (https://paystack.com)

<!-- https://github.com/binemmanuel/flutter_paystack_max -->

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


<p align="center">
![Pay with mobile money](https://drive.google.com/uc?id=1HIPgdRiaZlBbs7rgPhUtbZXg0OSNV3MI){ width=300px }
![Pay with mobile money options](https://drive.google.com/uc?id=1gJ40U3WVN38Y51dn8PQYZmlVf_uCkkPw){ width=300px }
![Pay with card](https://drive.google.com/uc?id=1MgMF1yVR7Sy5DRt7t8-t4ssjmrD-rywm){ width=300px }
![Successful payment](https://drive.google.com/uc?id=1PCiEZOex075jLmIpjIVlwnhY0yKAYjsD){ width=300px }
</p>



## Supported Platforms

-   Android and
-   iOS

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
        content: Text(transactionResponse.message),
    ));

    return;
}
```

3. Open the payment modal to accept payment

```dart
PaymentService.showPaymentModal(
    context,
    transaction: transactionResponse,
).then((_) async {
    final response = await PaymentService.verifyTransaction(
        paystackSecretKey: Const.paystackSecretKey,
        transactionResponse.data?.reference ?? transactionRequest.reference,
    );

    print(response); // Result of the confirmed payment
});
```

## Additional information

Visit the paystack documentation for more information https://paystack.com/docs/api/transaction

## :pencil: Contributing, :disappointed: Issues and :bug: Bug Reports

This project is open to contributions. </br>
Please feel very free to help improve the payment experience on Flutter. </br>
Experienced an issue or want to report a bug? Please, [report it here](https://github.com/binemmanuel/flutter_paystack_max/issues).
