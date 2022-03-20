import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemHeader extends StatefulWidget {

  ItemHeader({Key? key}) : super(key: key);

  @override
  State<ItemHeader> createState() => _ItemHeaderState();
}

class _ItemHeaderState extends State<ItemHeader> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(text: 'اسم السلعه',color: primaryColor,fontSize: 18,),
          ),
          Expanded(
            child: CustomText(text: 'السعر',color: primaryColor,fontSize: 18,),
          ),
          Expanded(
            child: CustomText(text: 'الرقم',color: primaryColor,fontSize: 18,),
          ),
          Expanded(
            child: CustomText(text: 'سعر القسط',color: primaryColor,fontSize: 18,),
          ),
          Expanded(child: CustomText(text: 'الكمية',color: primaryColor,fontSize: 18,),),
        ],
      ),
    );
  }
}
