enum PaystackPaymentChannel {
  card(value: 'card'),
  bank(value: 'bank'),
  ussd(value: 'ussd'),
  qr(value: 'qr'),
  mobileMoney(value: 'mobile_money'),
  bankTransfer(value: 'bank_transfer'),
  eft(value: 'eft');

  final String value;

  const PaystackPaymentChannel({required this.value});

  factory PaystackPaymentChannel.fromMap(String name) {
    return PaystackPaymentChannel.values.asNameMap()[name] ?? card;
  }

  String toMap() => value;
}
