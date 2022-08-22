import 'package:flutter/material.dart';
import 'package:netflix/API/customer-api.dart';
import 'package:netflix/API/general-api.dart';
import 'package:netflix/models/pref-model.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/splash-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerAPI>(create: (_) => CustomerAPI()),
        ChangeNotifierProvider<GeneralAPI>(create: (_) => GeneralAPI()),
        ChangeNotifierProvider<PrefModel>(create: (_) => PrefModel()),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        title: 'WoStore',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
