import 'package:asmaasuperadmin/Modules/products_model.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/widgets/add_screen/update_product.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemBody extends StatefulWidget {
  String id, name, selling, wholesale, installmentPrice, quantity;
  Products product;

  ItemBody(
      {Key? key,
      required this.name,
      required this.id,
      required this.installmentPrice,
      required this.selling,
      required this.wholesale,
      required this.quantity,
      required this.product,})
      : super(key: key);

  @override
  State<ItemBody> createState() => _ItemBodyState();
}

class _ItemBodyState extends State<ItemBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomText(
              text: widget.name.replaceAll('"', ''),
              color: primaryColor,
              fontSize: 18,
            ),
          ),
          Expanded(child: Row(children: [
            Expanded(
              child: CustomText(
                text: '${int.parse(widget.selling.replaceAll('"', ''))}',
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: CustomText(
                text: '${int.parse(widget.id.replaceAll('"', ''))}',
                color: primaryColor,
                fontSize: 18,
              ),
            ),
          ],)),
         Expanded(child: Row(children: [
           Expanded(
             child: CustomText(
               text: '${int.parse(widget.installmentPrice.replaceAll('"', ''))}',
               color: primaryColor,
               fontSize: 18,
             ),
           ),
           Expanded(
             child: CustomText(
               text: '${int.parse(widget.quantity.replaceAll('"', ''))}',
               color: primaryColor,
               fontSize: 18,
             ),
           ),
         ],)),

          Expanded(
            child: Align(
             alignment : Alignment.center,
              child: IconButton(
                icon: Icon(Icons.update),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateProduct(product: widget.product)),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
            alignment : Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
