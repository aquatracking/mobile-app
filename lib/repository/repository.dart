import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/views/auth/login_view.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

abstract class Repository {
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio();

    if (!kIsWeb) {
      PersistCookieJar persistCookieJar = PersistCookieJar(
        storage: FileStorage(
          "${(await getApplicationDocumentsDirectory()).path}/.cookies/",
        ),
      );

      dio.interceptors.add(
        CookieManager(persistCookieJar),
      );
    }

    String apiBaseUrlEnv = const String.fromEnvironment('API_BASE_URL');

    dio.options = BaseOptions(
      baseUrl: (apiBaseUrlEnv.isNotEmpty)
          ? apiBaseUrlEnv
          : 'https://aquatracking.fr/api',
      headers: {
        "Accept": "application/json",
        "user-agent":
            "AquaTracking/1.0.0 (Android; 11) dart/2.12.0 (dart:io)", // TODO: Change user-agent with correct values
      },
      responseType: ResponseType.json,
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.data["statusCode"] != null &&
              error.response?.data["code"] != null) {
            handler.next(
              ApiError(
                requestOptions: error.requestOptions,
                statusCode: error.response!.data["statusCode"],
                code: error.response!.data["code"],
              ),
            );
          } else {
            handler.next(error);
          }
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error is ApiError && error.code == "NOT_LOGGED") {
            NavigationService().replaceScreen(const LoginView());
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }
}
