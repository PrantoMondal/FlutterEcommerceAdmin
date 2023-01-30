import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/models/dashboard_item.dart';
import 'package:flutter_ecommerce_admin/page/product_page.dart';
import 'package:flutter_ecommerce_admin/page/report_page.dart';
import 'package:flutter_ecommerce_admin/page/settings_page.dart';
import 'package:flutter_ecommerce_admin/page/user_page.dart';
import 'package:flutter_ecommerce_admin/widgets/dashboard_item_view.dart';
import 'package:flutter_ecommerce_admin/page/category_page.dart';
import 'package:flutter_ecommerce_admin/page/order_page.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    //fetch category, app run er sathe sathei db theke tule ene rakhlam
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    //Product ene rakhlam
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) => DashboardItemView(
              item: dashboardItems[index],
              onPressed: (value) {
                final route = navigate(value);
                Navigator.pushNamed(context, route);
              })),
    );
  }

  String navigate(String value) {
    String route = '';
    switch (value) {
      case DashboardItem.product:
        route = ProductPage.routeName;
        break;
      case DashboardItem.category:
        route = CategoryPage.routeName;
        break;
      case DashboardItem.order:
        route = OrderPage.routeName;
        break;
      case DashboardItem.user:
        route = UserPage.routeName;
        break;
      case DashboardItem.settings:
        route = SettingsPage.routeName;
        break;
      case DashboardItem.report:
        route = ReportPage.routeName;
        break;
    }
    return route;
  }
}
