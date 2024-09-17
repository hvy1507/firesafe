// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesafe_vnex/utils/extensions/scope.ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum RequestType { GET, PUT, POST, DELETE }

abstract class BaseService {
  static Dio? _dio;

  static void _createDio() {
    _dio ??= Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? 'https://localhost:7283/api/v1',
    ))
      ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));

    if (kDebugMode) {
      _dio!.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient()..badCertificateCallback = (cert, host, port) => true;
          return client;
        },
        validateCertificate: (cert, host, port) => true,
      );
    }
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        (await FirebaseAuth.instance.currentUser?.getIdToken(true))?.apply((it) {
          options.headers['Authorization'] = 'Bearer $it';
        });
        return handler.next(options);
      },
    ));
  }

  Dio get dio {
    _createDio();
    return _dio!;
  }

  Future<Map<String, dynamic>?> getResult(
    String endpoint, {
    required RequestType requestType,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      late final Response<Map<String, dynamic>?> response;
      switch (requestType) {
        case RequestType.GET:
          response = await dio.get(
            endpoint,
            queryParameters: query,
          );
          break;
        case RequestType.PUT:
          response = await dio.put(
            endpoint,
            queryParameters: query,
            data: formData != null ? FormData.fromMap(formData) : body,
          );
          break;
        case RequestType.POST:
          response = await dio.post(
            endpoint,
            queryParameters: query,
            data: formData != null ? FormData.fromMap(formData) : body,
          );
          break;
        case RequestType.DELETE:
          response = await dio.delete(
            endpoint,
            queryParameters: query,
            data: formData != null ? FormData.fromMap(formData) : body,
          );
          break;
      }
      if (response.success) {
        return response.data;
      } else {
        throw RequestException(
          statusCode: response.statusCode!,
          message: response.data.toString(),
          errors: (response.data as List?)?.map((e) => e.toString()).toList() ?? [],
        );
      }
    } on DioException catch (e) {
      throw RequestException(
        statusCode: e.response?.statusCode ?? -1,
        message: (e.response?.data).toString(),
        errors: [],
      );
    }
  }
}

extension ResponseExt on Response {
  bool get success => 100 <= statusCode! && statusCode! <= 399;
}

class RequestException implements Exception {
  RequestException({required this.statusCode, required this.message, required this.errors});

  final int statusCode;
  final String message;
  final List<String> errors;
}
