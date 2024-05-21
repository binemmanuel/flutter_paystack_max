import 'dart:convert';

import 'package:flutter/foundation.dart';

import './models.dart';

class PaystackTransactionRequest {
  /// Unique transaction reference. Only -, ., = and alphanumeric characters allowed.
  final String reference;

  final String secretKey;

  /// The customer's email address
  final String email;

  /// Amount the customer is paying
  final double amount;

  /// The currency the customer is paying
  final PaystackCurrency currency;

  /// If transaction is to create a subscription to a predefined plan, provide
  /// plan code here. This would invalidate the value provided in amount
  final String? plan;

  /// Who bears Paystack charges? account or subaccount (defaults to account).
  final PaystackChargesBearer bearer;

  /// paystack documentation (https://paystack.com/docs/api/transaction/#initialize).
  /// Check the documentation on what fields to pass
  final Map<String, Object?>? metadata;

  /// Defines the payment method
  /// ["PaystackPaymentChannel.card", "PaystackPaymentChannel.bank", "PaystackPaymentChannel.ussd", "PaystackPaymentChannel.qr", "PaystackPaymentChannel.mobileMoney", "PaystackPaymentChannel.bankTransfer", "PaystackPaymentChannel.eft"]
  final List<PaystackPaymentChannel> channel;

  PaystackTransactionRequest({
    required this.reference,
    required this.secretKey,
    required this.email,
    required this.amount,
    required this.currency,
    this.plan,
    this.bearer = PaystackChargesBearer.account,
    this.metadata,
    required this.channel,
  });

  PaystackTransactionRequest copyWith({
    String? reference,
    String? secretKey,
    String? email,
    double? amount,
    PaystackCurrency? currency,
    String? plan,
    PaystackChargesBearer? bearer,
    Map<String, Object?>? metadata,
    List<PaystackPaymentChannel>? channel,
  }) {
    return PaystackTransactionRequest(
      reference: reference ?? this.reference,
      secretKey: secretKey ?? this.secretKey,
      email: email ?? this.email,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      plan: plan ?? this.plan,
      bearer: bearer ?? this.bearer,
      metadata: metadata ?? this.metadata,
      channel: channel ?? this.channel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'reference': reference});
    result.addAll({'secretKey': secretKey});
    result.addAll({'email': email});
    result.addAll({'amount': amount});
    result.addAll({'currency': currency.toMap()});
    if (plan != null) {
      result.addAll({'plan': plan});
    }
    result.addAll({'bearer': bearer.toMap()});
    if (metadata != null) {
      result.addAll({'metadata': metadata});
    }
    result.addAll({'channel': channel.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PaystackTransactionRequest.fromMap(Map<String, dynamic> map) {
    return PaystackTransactionRequest(
      reference: map['reference'] ?? '',
      secretKey: map['secretKey'] ?? '',
      email: map['email'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      currency: PaystackCurrency.fromMap(map['currency']),
      plan: map['plan'],
      bearer: PaystackChargesBearer.fromMap(map['bearer']),
      metadata: Map<String, Object?>.from(map['metadata']),
      channel: List<PaystackPaymentChannel>.from(
        map['channel']?.map((x) => PaystackPaymentChannel.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackTransactionRequest.fromJson(String source) =>
      PaystackTransactionRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaystackTransactionRequest(reference: $reference, secretKey: $secretKey, email: $email, amount: $amount, currency: $currency, plan: $plan, bearer: $bearer, metadata: $metadata, channel: $channel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackTransactionRequest &&
        other.reference == reference &&
        other.secretKey == secretKey &&
        other.email == email &&
        other.amount == amount &&
        other.currency == currency &&
        other.plan == plan &&
        other.bearer == bearer &&
        mapEquals(other.metadata, metadata) &&
        listEquals(other.channel, channel);
  }

  @override
  int get hashCode {
    return reference.hashCode ^
        secretKey.hashCode ^
        email.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        plan.hashCode ^
        bearer.hashCode ^
        metadata.hashCode ^
        channel.hashCode;
  }
}
