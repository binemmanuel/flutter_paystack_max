import 'dart:convert';

class PaystackInitializedTractionData {
  final String authorizationUrl;
  final String accessCode;
  final String reference;

  PaystackInitializedTractionData({
    required this.authorizationUrl,
    required this.accessCode,
    required this.reference,
  });

  PaystackInitializedTractionData copyWith({
    String? authorizationUrl,
    String? accessCode,
    String? reference,
  }) {
    return PaystackInitializedTractionData(
      authorizationUrl: authorizationUrl ?? this.authorizationUrl,
      accessCode: accessCode ?? this.accessCode,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'authorization_url': authorizationUrl});
    result.addAll({'access_code': accessCode});
    result.addAll({'reference': reference});

    return result;
  }

  factory PaystackInitializedTractionData.fromMap(Map<String, dynamic> map) {
    return PaystackInitializedTractionData(
      authorizationUrl: map['authorization_url'] ?? '',
      accessCode: map['access_code'] ?? '',
      reference: map['reference'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackInitializedTractionData.fromJson(String source) =>
      PaystackInitializedTractionData.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackResponseData(authorizationUrl: $authorizationUrl, accessCode: $accessCode, reference: $reference)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackInitializedTractionData &&
        other.authorizationUrl == authorizationUrl &&
        other.accessCode == accessCode &&
        other.reference == reference;
  }

  @override
  int get hashCode =>
      authorizationUrl.hashCode ^ accessCode.hashCode ^ reference.hashCode;
}
