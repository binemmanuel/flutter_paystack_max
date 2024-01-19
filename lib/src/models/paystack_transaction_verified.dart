import 'dart:convert';

import './models.dart';

class PaystackTransactionVerified {
  final bool status;
  final String message;
  final PaystackTransactionVerifiedData data;

  PaystackTransactionVerified({
    required this.status,
    required this.message,
    required this.data,
  });

  PaystackTransactionVerified copyWith({
    bool? status,
    String? message,
    PaystackTransactionVerifiedData? data,
  }) {
    return PaystackTransactionVerified(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'message': message});
    result.addAll({'data': data.toMap()});

    return result;
  }

  factory PaystackTransactionVerified.fromMap(Map<String, dynamic> map) {
    return PaystackTransactionVerified(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: PaystackTransactionVerifiedData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackTransactionVerified.fromJson(String source) =>
      PaystackTransactionVerified.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackTransactionVerificationResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackTransactionVerified &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
