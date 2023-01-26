import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/models/dashboard_item.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardItem item;
  final Function(String) onPressed;

  const DashboardItemView(
      {Key? key,
        required this.item,
        required this.onPressed
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed(item.title);
      },
      child:  Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 40,
              color: ,
            )
          ],
        ),

      ),
    );
  }
}
