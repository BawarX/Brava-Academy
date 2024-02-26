import 'package:http/http.dart';

class Service {
  void login(String email, String password) async {
    try {
      Response res = await post(
        Uri.parse('http://localhost:3000/user/get-user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          'email': email,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        print("Account Created");
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
