

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Database/db_helper.dart';
import 'screens/home_page.dart';
import 'screens/theme.dart';
import 'services/theme_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb(); //database initialized
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,

      themeMode: ThemeServices().theme,
      
      home: HomePage(),
    );
  }
}
