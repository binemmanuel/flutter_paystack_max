import 'dart:convert';

import './models.dart';

class PaystackTransactionVerifiedData {
  final int id;
  final String domain;
  final PaystackTransactionStatus status;
  final String reference;
  final String? receiptNumber;

  PaystackTransactionVerifiedData({
    required this.id,
    required this.domain,
    required this.status,
    required this.reference,
    this.receiptNumber,
  });

  PaystackTransactionVerifiedData copyWith({
    int? id,
    String? domain,
    PaystackTransactionStatus? status,
    String? reference,
    String? receiptNumber,
  }) {
    return PaystackTransactionVerifiedData(
      id: id ?? this.id,
      domain: domain ?? this.domain,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      receiptNumber: receiptNumber ?? this.receiptNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'domain': domain});
    result.addAll({'status': status.toMap()});
    result.addAll({'reference': reference});
    if (receiptNumber != null) {
      result.addAll({'receiptNumber': receiptNumber});
    }

    return result;
  }

  factory PaystackTransactionVerifiedData.fromMap(Map<String, dynamic> map) {
    return PaystackTransactionVerifiedData(
      id: map['id']?.toInt() ?? 0,
      domain: map['domain'] ?? '',
      status: PaystackTransactionStatus.fromMap(map['status']),
      reference: map['reference'] ?? '',
      receiptNumber: map['receiptNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackTransactionVerifiedData.fromJson(String source) =>
      PaystackTransactionVerifiedData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaystackTransactionVerificationData(id: $id, domain: $domain, status: $status, reference: $reference, receiptNumber: $receiptNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackTransactionVerifiedData &&
        other.id == id &&
        other.domain == domain &&
        other.status == status &&
        other.reference == reference &&
        other.receiptNumber == receiptNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        domain.hashCode ^
        status.hashCode ^
        reference.hashCode ^
        receiptNumber.hashCode;
  }
}
