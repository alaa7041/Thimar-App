import 'package:dio/dio.dart';
import 'package:thimar/core/logic/cache_helper.dart';

class DioHelper {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/", headers: {
      "Accept": "application/json",
      "Accept-Language": "ar",
    }),
  );

  Future<CustomResponse> sendData(String endPoint,
      {Map<String, dynamic>? data}) async {
    print("(POST)https://thimar.amr.aait-d.com/api/$endPoint");
    print('"Authorization": "Bearer ${CacheHelper.getToken()}"');
    try {
      final response = await _dio.post(endPoint,
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer ${CacheHelper.getToken()}",
          }));
      print(response.headers.map);
      return CustomResponse(
        isSuccess: true,
        message: response.data["message"],
        response: response,
      );
    } on DioException catch (ex) {
      print(ex.response);
      print(ex.error);
      print(ex.message);
      return CustomResponse(
        message: ex.response?.data["message"] ?? "",
        isSuccess: false,
        response: ex.response,
      );
    }
  }

  Future<CustomResponse> getData(String endPoint,
      {Map<String, dynamic>? data}) async {
    print("(GET)https://thimar.amr.aait-d.com/api/$endPoint");
    try {
      final response = await _dio.get(
        endPoint,
          data: data,
        queryParameters: data,options: Options(headers: {
        "Authorization": "Bearer ${CacheHelper.getToken()}",
      })
      );
      print(response.headers.map);
      return CustomResponse(
        isSuccess: true,
        message: response.data["message"],
        response: response,
      );
    } on DioException catch (ex) {
      String msg;
      try {
        msg = ex.response?.data["message"] ?? "";
      } catch (ex) {
        msg = "Something Wrong";
      }
      print(ex.response);
      print(ex.message);
      print(ex.error);
      return CustomResponse(
        message: msg,
        isSuccess: false,
        response: ex.response,
      );
    }
  }

}

class CustomResponse {
  late final String message;
  late final bool isSuccess;
  late final Response? response;

  CustomResponse({
    required this.message,
    required this.isSuccess,
    required this.response,
  });
}
