import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bloc/payment_bloc.dart';
import 'package:get/get.dart';

class PaymobWebViewScreen extends StatefulWidget {
  final String iframeUrl;
  const PaymobWebViewScreen({super.key, required this.iframeUrl});

  @override
  State<PaymobWebViewScreen> createState() => _PaymobWebViewScreenState();
}

class _PaymobWebViewScreenState extends State<PaymobWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _handled = false;

  void _handleUrl(String url) {
  if (_handled) return;
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  final success = uri.queryParameters['success'];
  if (success == null) return; // مش صفحة نتيجة

  _handled = true;
  final txnId = uri.queryParameters['id'] ?? 
      DateTime.now().millisecondsSinceEpoch.toString();

  if (success == 'true') {
    context.read<PaymentBloc>().add(PaymentSucceededEvent(transactionId: txnId));
  } else {
    final reason = uri.queryParameters['data.message'] ?? 'فشل الدفع';
    context.read<PaymentBloc>().add(PaymentFailedEvent(reason: reason));
  }
  Get.back(result: true);
}

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _isLoading = true),
        onPageFinished: (_) => setState(() => _isLoading = false),
        onWebResourceError: (_) {
          context.read<PaymentBloc>().add(
            const PaymentFailedEvent(reason: 'خطأ في تحميل صفحة الدفع'),
          );
          Navigator.of(context).pop(false);
        },
        onUrlChange: (c) => _handleUrl(c.url ?? ''),
        onNavigationRequest: (r) {
          _handleUrl(r.url);
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.iframeUrl));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('إتمام الدفع',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () {
            context.read<PaymentBloc>().add(
              const PaymentFailedEvent(reason: 'تم إلغاء عملية الدفع'),
            );
            Navigator.of(context).pop(false);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFEEEEEE)),
        ),
      ),
      body: Stack(children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF1D9E75), strokeWidth: 2.5),
                SizedBox(height: 16),
                Text('جاري تحميل صفحة الدفع...',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
              ],
            ),
          ),
      ]),
    );
  }
}
