
import '../../shared/network/api_provider.dart';
import 'models/login_response.dart';

class LoginClient {
  // argument-less constructor
  LoginClient();

  final ApiProvider apiProvider = ApiProvider();

  Future<void> login({
    required String email,
    required String password,
    required void Function(LoginData loginData) onSuccess,
    required void Function(String errorMessage) onError,
  }) async {
    try {
      // { "email":"sauravsinha007@gmail.com", "password":"EYK00D", "isAdminLogin":"1"}
      final Map<String, dynamic> data = await apiProvider.postRequest(
        'staff/login-staff',
        <String, dynamic>{'email': email, 'password': password, 'isAdminLogin':"1"},
      );
      final LoginData loginData = LoginData.fromJson(data);
      // log('getting response of login api');
      return onSuccess(loginData);
    } catch (e) {
      // log('getting error response of login api');
      return onError(e.toString());
    }
  }
}
