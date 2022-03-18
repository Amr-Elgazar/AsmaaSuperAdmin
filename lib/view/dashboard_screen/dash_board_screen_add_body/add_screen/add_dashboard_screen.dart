import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/add_screen/widget/add_category.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/add_screen/widget/add_section.dart';
import 'package:asmaasuperadmin/widgets/custom_button.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/listview.dart';

class AddDashboardScreen extends StatefulWidget {
  const AddDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AddDashboardScreen> createState() => _AddDashboardScreenState();
}

class _AddDashboardScreenState extends State<AddDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListViewScreen(text: 'إضافه قسم', icon: 'assets/icons/add-to-cart.png', onPress: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSection()),
              );}),
              ListViewScreen(text: 'إضافه صنف', icon: 'assets/icons/add-to-cart.png', onPress: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const addCategory()),
              );}),
            ],
          ),
        ),
      ),
    );
  }
}






