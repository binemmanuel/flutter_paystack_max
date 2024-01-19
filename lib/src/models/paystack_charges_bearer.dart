enum PaystackChargesBearer {
  account,
  subaccount;

  factory PaystackChargesBearer.fromMap(String name) {
    return PaystackChargesBearer.values.asNameMap()[name] ?? account;
  }

  String toMap() => name;
}
