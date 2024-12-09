import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:ecom_admin/pages/order_page.dart';
import 'package:flutter/material.dart';

import '../pages/view_product_page.dart';

class DashboardItemModel{
 final String title;
 final IconData iconData;
 final String routeName;

 const DashboardItemModel({required this.title,required this.iconData,required  this.routeName});
}
 const dashboarditem= [
  DashboardItemModel(title: 'Add Product', iconData: Icons.card_giftcard, routeName: NewProductPage.routeName),
  DashboardItemModel(title: 'View Product', iconData: Icons.list, routeName: ViewProductPage.routeName),
  DashboardItemModel(title: 'Category', iconData: Icons.category, routeName:CategoryPage.routeName),
  DashboardItemModel(title: 'Order', iconData: Icons.monetization_on, routeName:OrderPage.routeName),
 ];
