part of 'dio_imports.dart';

class DioHelper {
  late Dio _dio;
  late DioCacheManager _manager;
  BuildContext context;
  final bool forceRefresh;
  final String? contentType;

  DioHelper({this.forceRefresh = true, required this.context, this.contentType}) {
    printDebug("contentType $contentType"); 
    _dio = Dio(
      BaseOptions(
          baseUrl: ApiProvider.baseUrl,
          contentType: contentType ?? 'application/json'
          ),
    )
      ..interceptors.add(_getCacheManager().interceptor)
      ..interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (data) => log(data.toString())));
  }

  DioCacheManager _getCacheManager() {
    _manager = DioCacheManager(CacheConfig(
        baseUrl: ApiProvider.baseUrl, defaultRequestMethod: "POST"));
    return _manager;
  }

  Options _buildCacheOptions() {
    return buildCacheOptions(
      const Duration(days: 3),
      maxStale: const Duration(days: 7),
      forceRefresh: forceRefresh,
      options: Options(extra: {}),
    );
  }

  Future<dynamic> get(
      {required String url, Map<String, String>? headers,
      String?  contentType
      }) async {
    _dio.options.headers = DioUtils.header ?? await _getHeader();
    try {
      var response = await _dio.get(url, options: _buildCacheOptions());
      debugPrint("response code  ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      showErrorMessage(e.response);
    }
    return null;
  }

  Future<dynamic> post(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, String>? headers,
       String? contentType,}) async {
    if (showLoader) DioUtils.showLoadingDialog();
    FormData formData = FormData.fromMap(body);
    bool haveFile = false;
    body.forEach((key, value) async {
      if ((value) is File) {
        haveFile = true;
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        haveFile = true;
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      }
    });
    _dio.options.headers = DioUtils.header ?? await _getHeader();
    printDebug('headers ${_dio}');
    //create multipart request for POST or PATCH method

    try {
      printDebug("url are you hitting ${url}");
      printDebug("body valud are ${body}");
      var response = await _dio.post("$url", data: haveFile ? formData : body);
      if (showLoader) DioUtils.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 400 &&
          response.statusMessage == 'Validation failed') {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) DioUtils.dismissDialog();
      if (e.response?.statusCode == 400) {
        // Handle validation errors
        printDebug("Validation error");
        List<dynamic>? validationErrors = e.response?.data['data'];
        if (validationErrors != null) {
          return e.response
              ?.data; // Return the error response for further processing
        }
      }      
      if (e.response?.statusCode == 422) {
        return e.response?.data;       
      }      
      else {
        // Handle other non-2xx errors
        printDebug("dio helper catch post request error");
        showErrorMessage(e.response);
      }
    }

    return null;
  }

  Future<dynamic> put(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, String>? headers}) async {
    if (showLoader) DioUtils.showLoadingDialog();
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    bool haveFile = false;
    body.forEach((key, value) async {
      if ((value) is File) {
        haveFile = true;
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        haveFile = true;
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      }
    });

    _dio.options.headers = DioUtils.header ?? await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.put(url, data: haveFile ? formData : body);
      debugPrint("response ${response.statusCode}");
      if (showLoader) DioUtils.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) DioUtils.dismissDialog();
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> patch(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, String>? headers}) async {
    if (showLoader) DioUtils.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = DioUtils.header ?? await _getHeader();
    try {
      var response = await _dio.patch(url, data: body);
      debugPrint("response ${response.statusCode}");
      if (showLoader) DioUtils.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) DioUtils.dismissDialog();
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> delete(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, String>? headers}) async {
    if (showLoader) DioUtils.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = DioUtils.header ?? await _getHeader();
    try {
      var response = await _dio.delete(url, data: body);
      debugPrint("body response ${response.statusCode}");
      if (showLoader) DioUtils.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) DioUtils.dismissDialog();
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> uploadChatFile(String url, Map<String, dynamic> body,
      {bool showLoader = true}) async {
    if (showLoader) DioUtils.showLoadingDialog();
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) async {
      if ((value) is File) {
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {
        // requestData.addAll({"$key":"$value"});
      }
    });

    _dio.options.headers = DioUtils.header ?? await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.post(url, data: formData);
      debugPrint("response ${response.statusCode}");
      debugPrint("response ${response.statusMessage}");
      if (showLoader) DioUtils.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 400 &&
          response.statusMessage == 'Validation failed') {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) DioUtils.dismissDialog();
      showErrorMessage(e.response);
    }

    return null;
  }

  void _printRequestBody(Map<String, dynamic> body) {
    debugPrint(
        "-------------------------------------------------------------------");
    log("$body");
    debugPrint(
        "-------------------------------------------------------------------");
  }

  showErrorMessage(Response? response) {
    if (response == null) {
      debugPrint("failed response Check Server");
      LoadingDialog.showToastNotification("Check Server");
    } else {
      debugPrint("failed response ${response.statusCode}");
      var data = response.data;
      if (data is String) data = json.decode(response.data);
      switch (response.statusCode) {
        case 500:
          LoadingDialog.showToastNotification(data["msg"].toString());
          break;
        case 400:
          if (data != null) {
            Map<String, dynamic> errors = data;
            errors.forEach((key, value) {
              List<String> lst = List<String>.from(value.map((e) => e));
              lst.forEach((e) {
                LoadingDialog.showToastNotification(e);
              });
            });
          } else {
            LoadingDialog.showToastNotification(data["msg"].toString());
          }
          break;
        case 401:
        case 301:
        case 302:
          // tokenExpired();
          break;
      }
    }
  }

  _getHeader() async {
    String? token = GlobalState.instance.get("token");
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // void tokenExpired()async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   /// TODO navigate to logout page from here
  // }
}
