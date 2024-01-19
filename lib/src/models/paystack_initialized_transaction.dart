import 'dart:convert';

import './models.dart';

class PaystackInitializedTraction {
  final bool status;
  final String message;
  final PaystackInitializedTractionData? data;

  PaystackInitializedTraction({
    required this.status,
    required this.message,
    this.data,
  });

  PaystackInitializedTraction copyWith({
    bool? status,
    String? message,
    PaystackInitializedTractionData? data,
  }) {
    return PaystackInitializedTraction(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'message': message});
    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }

    return result;
  }

  factory PaystackInitializedTraction.fromMap(Map<String, dynamic> map) {
    return PaystackInitializedTraction(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] != null
          ? PaystackInitializedTractionData.fromMap(map['data'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackInitializedTraction.fromJson(String source) =>
      PaystackInitializedTraction.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackInitializedTraction &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
