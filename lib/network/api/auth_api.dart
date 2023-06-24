import 'package:biz_track/features/auth/model/login_response.dart';
import 'package:biz_track/features/auth/model/register_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';


class AuthApi extends ApiClient {
  
  Future<LoginResponse?> login({String? email, String? password}) async {
    final res = await http.post(AppEndpoints.login, data: {
      "username": email,
      "password": password
    });
    return LoginResponse.fromJson(res.data);
  }

  Future<LoginResponse?> employeeLogin({String? accessCode, String? password}) async {
    final res = await http.post(AppEndpoints.employeeLogin, data: {
      "accessCode": accessCode,
      "password": password
    });
    return LoginResponse.fromJson(res.data);
  }

  Future<RegisterResponse?> register({
    String? businessName, 
    String? email, 
    String? password, 
    String? phoneNumber
  }) async {
    final res = await http.post(AppEndpoints.register, data: {
      "businessName": businessName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber
    });
    return RegisterResponse.fromJson(res.data);
  }

}