import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../widgets/widgets.dart';

class PaymentService {
  static const baseUrl = 'https://api.paystack.co';

  /// Initialize a transaction
  static Future<PaystackInitializedTraction> initializeTransaction(
    PaystackTransactionRequest request,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/transaction/initialize');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${request.secretKey}',
        },
        body: PaystackTransactionRequest.fromMap(request.toMap()
              ..addAll({
                'metadata': {...?request.metadata, 'cancel_action': 'cancel'}
              }))
            .toJson(),
      );

      return PaystackInitializedTraction.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  /// Show a model to allow the choose a payment method and make payment
  ///
  /// [callbackUrl] Callback URL must match the one specified on your paystack dashboard,
  static Future<void> showPaymentModal(
    BuildContext context, {
    VoidCallback? onClosing,
    required String callbackUrl,
    required PaystackInitializedTraction transaction,
    Color? backgroundColor,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: backgroundColor,

      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: MediaQuery.of(context).size.height * 0.5,
      ),

      //
      builder: (context) => PaymentModelWidget(
        transaction: transaction,
        callbackUrl: callbackUrl,
        onClosing: () => onClosing?.call(),
      ),
    );
  }

  /// Confirm the status of a transaction
  static Future<PaystackTransactionVerified> verifyTransaction(
    String reference, {
    required String paystackSecretKey,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/transaction/verify/$reference',
      );

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $paystackSecretKey'},
      );

      return PaystackTransactionVerified.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
