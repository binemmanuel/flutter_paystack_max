enum PaystackTransactionStatus {
  failed,
  success,
  abandoned,
  reversed;

  factory PaystackTransactionStatus.fromMap(String name) {
    return PaystackTransactionStatus.values.asNameMap()[name] ?? failed;
  }

  String toMap() => name;
}
