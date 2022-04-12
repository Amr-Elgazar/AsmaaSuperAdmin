import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/products_model.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/widgets/add_screen/update_product.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/primary_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../dashboard_screen.dart';

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
                  print(widget.product);
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
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  ServData.deleteProduct(id: int.parse(widget.product.id)).then((value) {
                    if(value == 'Delete PRODUCT successfully'){
                      _showSuccessDialog(context, 'تم الحذف بنجاح');
                    }else{
                      _showErrorDialog('لم يتم الحذف ', 'حذف المنتجات', context);
                    }
                  }).whenComplete(() {

                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context , String message) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        title: 'حذف المنتجات',
        desc: message,
        btnOkOnPress: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {

        }).show();
  }

  void _showErrorDialog(String message, String title, BuildContext context) {

    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: title,
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red).show();

  }
}
