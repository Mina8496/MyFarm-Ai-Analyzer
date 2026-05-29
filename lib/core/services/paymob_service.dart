import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../features/payment/data/models/payment_model.dart';
import '../network/paymob_client.dart';

// ─── Paymob Service ───────────────────────────────────────────────
// ثلاث خطوات لإتمام الدفع:
// 1. Authentication  →  الحصول على token
// 2. Create Order    →  إنشاء الطلب والحصول على order_id
// 3. Payment Key     →  الحصول على payment_token للـ iframe
// ──────────────────────────────────────────────────────────────────

class PaymobService {
  final Dio _dio = PaymobDioClient.instance;

  Future<String> initPayment({
    required int amountCents,
    required BillingData billingData,
  }) async {
    try {
      final response = await _dio.post(
        PaymobConstants.authEndpoint,
        data: {
          'amount_cents': amountCents,
          'billing_data': billingData.toJson(),
        },
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final iframeUrl = response.data['iframe_url'] as String?;
      if (iframeUrl == null || iframeUrl.isEmpty) {
        throw const PaymobApiException(message: 'لم يتم استلام iframe URL');
      }
      return iframeUrl;
    } on DioException catch (e) {
      // ← وده كمان
      debugPrint('❌ DIO ERROR TYPE: ${e.type}');
      debugPrint('❌ DIO STATUS: ${e.response?.statusCode}');
      debugPrint('❌ DIO RESPONSE: ${e.response?.data}');

      throw PaymobApiException(
        message: switch (e.type) {
          DioExceptionType.connectionTimeout ||
          DioExceptionType.receiveTimeout => 'انتهت مهلة الاتصال',
          DioExceptionType.connectionError => 'لا يوجد اتصال بالإنترنت',
          DioExceptionType.badResponse =>
            e.response?.data?['error'] as String? ?? 'خطأ في الخادم',
          _ => e.message ?? 'خطأ غير معروف',
        },
        statusCode: e.response?.statusCode,
      );
    }
  }
}
