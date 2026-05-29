import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ─── Paymob API Constants ─────────────────────────────────────────
class PaymobConstants {
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String authEndpoint =
      'https://red-chinchilla-803890.hostingersite.com/MyFarm_payment.php';
  static const String ordersEndpoint = '/ecommerce/orders';
  static const String paymentKeysEndpoint = '/acceptance/payment_keys';
  static const String iframeBaseUrl =
      'https://accept.paymob.com/api/acceptance/iframes';

}

// ─── Dio Client ───────────────────────────────────────────────────
class PaymobDioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Logging interceptor (فقط في development)
     if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => debugPrint('🔷 Paymob: $obj'),
    ));
  }

    // Retry interceptor بسيط
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            // يمكنك إضافة retry logic هنا
            return handler.next(e);
          }
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}

// ─── API Exception ────────────────────────────────────────────────
class PaymobApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const PaymobApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'PaymobApiException($statusCode): $message';
}
