import 'dart:convert';

import 'package:flutter/foundation.dart';

import './models.dart';

class PaystackMetadata {
  final String cartId;
  final List<PaystackMetadataCustomField> customFields;

  PaystackMetadata({
    required this.cartId,
    required this.customFields,
  });

  PaystackMetadata copyWith({
    String? cartId,
    List<PaystackMetadataCustomField>? customFields,
  }) {
    return PaystackMetadata(
      cartId: cartId ?? this.cartId,
      customFields: customFields ?? this.customFields,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'cart_id': cartId});
    result
        .addAll({'custom_fields': customFields.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PaystackMetadata.fromMap(Map<String, dynamic> map) {
    return PaystackMetadata(
      cartId: map['cart_id'] ?? '',
      customFields: List<PaystackMetadataCustomField>.from(map['custom_fields']
          ?.map((x) => PaystackMetadataCustomField.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackMetadata.fromJson(String source) =>
      PaystackMetadata.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackMetadata(cartId: $cartId, customFields: $customFields)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackMetadata &&
        other.cartId == cartId &&
        listEquals(other.customFields, customFields);
  }

  @override
  int get hashCode => cartId.hashCode ^ customFields.hashCode;
}
