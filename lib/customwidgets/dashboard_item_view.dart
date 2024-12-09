import 'package:ecom_admin/models/dashboard_models.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  const DashboardItemView({super.key,required this.model});
  final DashboardItemModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context,model.routeName),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(model.iconData,color: Colors.grey,size: 30,),
              const SizedBox(height: 20,),
              Text(model.title,style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
