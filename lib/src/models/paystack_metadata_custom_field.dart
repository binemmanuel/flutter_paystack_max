import 'dart:convert';

class PaystackMetadataCustomField {
  final String displayName;
  final String variableName;
  final String value;

  PaystackMetadataCustomField({
    required this.displayName,
    required this.variableName,
    required this.value,
  });

  PaystackMetadataCustomField copyWith({
    String? displayName,
    String? variableName,
    String? value,
  }) {
    return PaystackMetadataCustomField(
      displayName: displayName ?? this.displayName,
      variableName: variableName ?? this.variableName,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'displayName': displayName});
    result.addAll({'variableName': variableName});
    result.addAll({'value': value});

    return result;
  }

  factory PaystackMetadataCustomField.fromMap(Map<String, dynamic> map) {
    return PaystackMetadataCustomField(
      displayName: map['displayName'] ?? '',
      variableName: map['variableName'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackMetadataCustomField.fromJson(String source) =>
      PaystackMetadataCustomField.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackMetadataCustomFields(displayName: $displayName, variableName: $variableName, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackMetadataCustomField &&
        other.displayName == displayName &&
        other.variableName == variableName &&
        other.value == value;
  }

  @override
  int get hashCode =>
      displayName.hashCode ^ variableName.hashCode ^ value.hashCode;
}
