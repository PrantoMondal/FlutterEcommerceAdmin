import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/page/category_page.dart';
import 'package:flutter_ecommerce_admin/page/dashboard_page.dart';
import 'package:flutter_ecommerce_admin/page/launcher_page.dart';
import 'package:flutter_ecommerce_admin/page/login_page.dart';
import 'package:flutter_ecommerce_admin/page/order_page.dart';
import 'package:flutter_ecommerce_admin/page/product_page.dart';
import 'package:flutter_ecommerce_admin/page/report_page.dart';
import 'package:flutter_ecommerce_admin/page/settings_page.dart';
import 'package:flutter_ecommerce_admin/page/user_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LoginPage.routeName: (_) => LoginPage(),
        DashboardPage.routeName: (_) => DashboardPage(),
        ProductPage.routeName: (_) => ProductPage(),
        CategoryPage.routeName: (_) => CategoryPage(),
        OrderPage.routeName: (_) => OrderPage(),
        UserPage.routeName: (_) => UserPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
        ReportPage.routeName: (_) => ReportPage(),
      },
    );
  }
}


