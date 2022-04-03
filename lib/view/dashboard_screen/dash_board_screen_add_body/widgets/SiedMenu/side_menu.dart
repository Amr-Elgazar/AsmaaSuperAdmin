import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final Function({required int possition}) screensControl;
  final int getPossition;

   const SideMenu({Key? key, required this.screensControl , required this.getPossition}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(getPossition );
    return Drawer(
      backgroundColor: Colors.blueAccent,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('assets/logo2.png'),
          ),
          DrawerListTile(
            title: "عرض المنتجات",
            possition: 0,
            press: () => screensControl(possition: 0),
            index: getPossition,
          ),
          DrawerListTile(
            title: "إضافة قسم",
            possition: 1,
            index: getPossition,
            press: () => screensControl(possition: 1),

          ),
          DrawerListTile(
            title: "إضافة منتج",
            possition: 2,
            press: () => screensControl(possition: 2),
            index: getPossition,
          ),
          DrawerListTile(
            title: "إدارة الطلبيات",
            possition: 3,
            index: getPossition,
            press: () => screensControl(possition: 3) ,
          ),
          DrawerListTile(
            title: "حسابات القسط",
            possition: 4,
            index: getPossition,
            press: () => screensControl(possition: 4),
          ),

          DrawerListTile(
            title: "حسابات الكاش أو الجملة",
            possition: 5,
            index: getPossition,
            press: () => screensControl(possition: 5),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
   DrawerListTile({ Key? key, required this.title, required this.possition,required this.index, required this.press}) : super(key: key);

  final String title;
  final int possition;
   final int index;
  final VoidCallback press;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      /*leading: Image.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
       */
      title: Text(
        title,
        style:  TextStyle(color: index == possition ? Colors.lightGreen :Colors.white , fontWeight: FontWeight.bold , fontSize: 12.0),
      ),
    );
  }
}