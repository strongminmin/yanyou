import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/pages/index.dart';
import 'package:yanyou/provider/CollegeProvider.dart';
import 'package:yanyou/provider/TalkProvider.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TalkProvider>(create: (_) => TalkProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<CollegeProvider>(
              create: (_) => CollegeProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
      home: Index(title: '研优'),
    );
  }
}
