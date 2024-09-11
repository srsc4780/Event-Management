part of 'repository.dart';

class RepositoryMethods {
  final BuildContext context;

  RepositoryMethods(this.context);



  Future<UserModel?> login(data) async {
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        toJsonFunc: (json) => UserModel.fromJson(json),
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.login);
  }

  Future<Map<String, dynamic>> postRegisterApi(Map<String, dynamic> body) async {
    printDebug(body);
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        json: body,
        toJsonFunc: (json) => json,
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.registration,
        contentType: 'application/json' // Content-Type parameter
        );
  }

  Future<Map<String, dynamic>> postLoginApi(Map<String, dynamic> body) async {
    printDebug(body);
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        json: body,
        toJsonFunc: (json) => json,
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.login,
        contentType: 'application/json' // Content-Type parameter
        );
  }

  Future<DashboardModel?> getDashboardData() async {
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.get,
        toJsonFunc: (json) => DashboardModel.fromJson(json),
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.dashboard,
        contentType: 'application/json' // Content-Type parameter
        );
  }

  Future<EventListModel?> getEventList(data) async {
    printDebug(data);
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        toJsonFunc: (json) => EventListModel.fromJson(json),
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.eventFilter,
        contentType: 'application/json' // Content-Type parameter
        );
  }

  
  Future<Map<String, dynamic>> postEvent(Map<String, dynamic> body) async {
    printDebug(body);
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        json: body,
        toJsonFunc: (json) => json,
        returnDataFun: (data) => data,
        showLoader: true,
        name: ApiProvider.eventCreate,
        contentType: 'application/json' // Content-Type parameter
        );
  }


  Future forgetPass({required data}) async {
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        json: data,
        showLoader: true,
        toJsonFunc: (json) => json,
        returnDataFun: (data) => data,
        name: ApiProvider.forgetPassword);
  }

  Future resetPass({required data}) async {
    return await GenericHttp(context).callApi(
        returnType: ReturnType.model,
        methodType: MethodType.post,
        json: data,
        showLoader: true,
        toJsonFunc: (json) => json,
        returnDataFun: (data) => data,
        name: ApiProvider.resetPassword);
  }
}
