import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  static const String routeName = '/productdetails';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}
class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel product;

  @override
  void didChangeDependencies() {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    product = context.watch<ProductProvider>().getProductFromListById(id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl,
            height: 250,
            width: double.infinity,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 100,
              ),
            ),
            fadeInDuration: const Duration(milliseconds: 1000),
            fadeInCurve: Curves.bounceInOut,
          ),
          ListTile(
            title: Text(product.productName),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Price:${product.price}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialogue(
                  title: 'Update Price',
                  positiveButtonText: 'Update price',
                  textInputType: TextInputType.number,
                  context: context,
                  onSave: (value) {
                    context.read<ProductProvider>().updateSingleProductField(
                        product.id!, 'price', num.parse(value));
                    showMsg(context, 'Price updated');
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Discount:${product.discountPercent}%'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Price after discount:${product.priceAfterDiscount}'),
          ),
          ListTile(
            title: Text('Stock:${product.stock}'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
          SwitchListTile(
            value: product.available,
            title: Text('Available'),
            onChanged: (value) {
              context
                  .read<ProductProvider>()
                  .updateSingleProductField(product.id!, 'available', value);
              showMsg(context, 'Status Updated');
            },
          ),
        ],
      ),
    );
  }
}
