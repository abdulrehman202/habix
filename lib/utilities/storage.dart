import 'package:shared_preferences/shared_preferences.dart';

Future<String> getDataFromLocalStorage(String key)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key)??'';
  }

addDataToLocalStorage(String key, String value)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }
