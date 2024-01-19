import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/models.dart';

class PaymentModelWidget extends StatefulWidget {
  const PaymentModelWidget({
    super.key,
    required this.transaction,
    required this.onClosing,
    this.onWebResourceError,
    this.confirmationButton,
  });

  final PaystackInitializedTraction transaction;
  final VoidCallback onClosing;
  final ValueSetter<WebResourceError>? onWebResourceError;
  final Widget? confirmationButton;

  @override
  State<PaymentModelWidget> createState() => _PaymentModelWidgetState();
}

class _PaymentModelWidgetState extends State<PaymentModelWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final controller = WebViewController();

  double loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loadingProgress = progress / 100;
            setState(() {});
          },

          //
          onWebResourceError: (WebResourceError error) {},

          //
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
        widget.transaction.data!.authorizationUrl,
      ));
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: animationController,
      onClosing: widget.onClosing,

      //
      builder: (context) {
        if (loadingProgress < 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(value: loadingProgress),
          );
        }

        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: widget.confirmationButton ??

                  // Default action button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
            ),

            //
            Expanded(
              child: WebViewWidget(
                controller: controller,
                gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
              ),
            ),
          ],
        );
      },
    );
  }
}
