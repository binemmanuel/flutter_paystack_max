import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/models.dart';

class PaymentModelWidget extends StatefulWidget {
  const PaymentModelWidget({
    super.key,
    required this.transaction,
    required this.callbackUrl,
    required this.onClosing,
    this.onWebResourceError,
    this.confirmationButton,
  });

  final PaystackInitializedTraction transaction;
  final String callbackUrl;
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
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.description),
            ));

            Navigator.pop(context);
          },

          //
          onNavigationRequest: (NavigationRequest request) async {
            final url = request.url;

            /// Prevent navigation when the user chooses to pay with USSD
            /// and taps on the USSD Code
            if (url.contains('tel:')) {
              final uri = Uri.parse(url);
              // Open the url on phone
              if (!(await canLaunchUrl(uri))) {
                return NavigationDecision.prevent;
              }

              await launchUrl(uri);

              return NavigationDecision.prevent;
            }

            if (url.endsWith('cancel')) {
              Navigator.pop(context);

              return NavigationDecision.prevent;
            }

            if (url.contains(widget.callbackUrl)) {
              Navigator.pop(context);

              return NavigationDecision.prevent;
            }

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

        return WebViewWidget(
          controller: controller,
          gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
        );
      },
    );
  }
}
