import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/primary_color.dart';
import 'package:flutter/material.dart';
import 'dash_board_screen_add_body/add_screen/add_dashboard_screen.dart';
import 'dash_board_screen_add_body/widgets/listview.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ListViewScreen(text: 'أضافه', icon: 'assets/icons/add-to-cart.png', onPress: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const AddDashboardScreen()),
                 );
               }),
                ListViewScreen(text: 'أداره حسابات', icon: 'assets/icons/accounts.png', onPress: (){}),
                ListViewScreen(text: 'الجرد', icon: 'assets/icons/inventory.png', onPress: (){}),
                ListViewScreen(text: 'تقارير', icon: 'assets/icons/report.png', onPress: (){}),
              ],
            ),
          ),
      ),
    );
  }
}
