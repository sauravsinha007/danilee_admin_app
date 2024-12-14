import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String apiServerURL = "http://18.218.6.148:2021/v1/";
  //http://18.218.6.148:2021/v1/staff/login-staff
      //'https://altascribe.com/PhoneApp/'; //'http://34.239.167.57/PhoneApp/';
  final Duration timeoutDuration = const Duration(seconds: 30);

  String getApiPath(String endpoint) => apiServerURL + endpoint;

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    try {
      final http.Response response = await http
          .get(Uri.parse(getApiPath(endpoint)))
          .timeout(timeoutDuration);
      return _handleResponse(response);
    } on TimeoutException {
      return _timeoutResponse();
    }
  }

  Future<Map<String, dynamic>> postRequest(
    String endpoint,
    Map<String, dynamic> fields,
  ) async {
    try {
      final http.Response response = await http
          .post(
            Uri.parse(getApiPath(endpoint)),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(fields),
          )
          .timeout(timeoutDuration);

      return _handleResponse(http.Response(response.body, response.statusCode));
    } on TimeoutException {
      return _timeoutResponse();
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      //throw Exception('Failed to load data');
      return _errorResponse();
    }
  }

  Map<String, dynamic> _timeoutResponse() {
    return <String, dynamic>{
      'Error': true,
      'ErrorMessage': 'Request timed out',
    };
  }

  Map<String, dynamic> _errorResponse() {
    return <String, dynamic>{
      'Error': true,
      'ErrorMessage': 'Something went wrong',
    };
  }
}
