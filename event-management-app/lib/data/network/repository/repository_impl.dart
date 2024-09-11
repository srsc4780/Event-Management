part of 'repository.dart';

class RepositoryImpl {
  late BuildContext _context;
  late RepositoryMethods _repositoryMethods;

  RepositoryImpl(BuildContext context) {
    _context = context;
    _repositoryMethods = RepositoryMethods(_context);
  }

  Future<UserModel?> login(data) =>
      _repositoryMethods.login(data);


  Future forgetPass(final data) => _repositoryMethods.forgetPass(data: data);

  Future resetPass(final data) => _repositoryMethods.resetPass(data: data);

  Future<DashboardModel?> getDashboardData() =>
      _repositoryMethods.getDashboardData();

  Future<EventListModel?> getEventList(data) =>
      _repositoryMethods.getEventList(data);
 Future<Map<String, dynamic>> postEvent(data) =>
      _repositoryMethods.postEvent(data);
      

 Future<Map<String, dynamic>> postRegister(data) =>
      _repositoryMethods.postRegisterApi(data);

 Future<Map<String, dynamic>> postLogin(data) =>
      _repositoryMethods.postLoginApi(data);


}
