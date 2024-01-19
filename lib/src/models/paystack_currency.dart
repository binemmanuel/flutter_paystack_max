enum PaystackCurrency {
  ngn(value: 'NGN'),
  ghs(value: 'GHS'),
  usd(value: 'USD'),
  zar(value: 'ZAR'),
  kes(value: 'KES');

  final String value;

  const PaystackCurrency({required this.value});

  factory PaystackCurrency.fromMap(String name) {
    return PaystackCurrency.values.asNameMap()[name] ?? ngn;
  }

  String toMap() => value;
}
