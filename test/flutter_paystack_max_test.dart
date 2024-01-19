import 'package:flutter_paystack_max/src/models/models.dart';
import 'package:flutter_paystack_max/src/services/payment_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Initialize payment', () async {
    final request = PaystackTransactionRequest(
      reference: 'ps_${DateTime.now().microsecondsSinceEpoch}',
      secretKey: '....',
      email: 'test@mail.com',
      amount: 15 * 100,
      currency: PaystackCurrency.ghs,
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

    final response = await PaymentService.initializeTransaction(request);

    expect(response, isA<PaystackInitializedTraction>());
    expect(response.message, 'Authorization URL created');
    expect(response.data, isA<PaystackInitializedTractionData?>());
  });
}
