import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/widgets/product/products.dart';
import 'package:flutter/material.dart';

import 'dash_board_screen_add_body/widgets/SiedMenu/side_menu.dart';
import 'dash_board_screen_add_body/widgets/add_screen/add_category.dart';
import 'dash_board_screen_add_body/widgets/add_screen/add_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0 ;
  Widget screens({required possition}) {
    if (possition == 0) {
       getPossition(index :possition);
      return const ProductsData();
    } else if (possition == 1) {
        getPossition(index :possition);
      return const AddSection();
    } else if (possition == 2) {
      getPossition(index :possition);
      return const AddCategory();
    }else {
      return Container();
    }
  }

  int getPossition({int index = 0}) {
    setState(() {
      this.index = index;
    });

    return index;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: SideMenu(
          screensControl: screens,
          getPossition: getPossition(index: index),
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SideMenu(
                screensControl: screens,
                getPossition: getPossition(index: index),
              )),
              Expanded(flex: 5, child: screens(possition: index))
            ],
          ),
        ),
      ),
    );
  }
}
