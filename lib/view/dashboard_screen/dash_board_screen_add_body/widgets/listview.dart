import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key, required this.text, required this.icon, required this.onPress}) : super(key: key);
  final String text;
  final String icon;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Material(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(child: Image.asset(icon , width: SizeConfig.screenWidth! * 0.05, height: SizeConfig.screenHeight! * 0.05,),radius: 40,backgroundColor: Colors.white,),
            Center(child: CustomText(text: text,fontWeight: FontWeight.bold, fontSize: 20,)),
            IconButton(onPressed: onPress, icon: Icon(Icons.arrow_right,size: 30,))
          ],
        ),
      ),
    );
  }
}
