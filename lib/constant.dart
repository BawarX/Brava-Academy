 import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences ;

 Future<SharedPreferences> GetSharedprefrence ()async{
  return await SharedPreferences.getInstance();
}


