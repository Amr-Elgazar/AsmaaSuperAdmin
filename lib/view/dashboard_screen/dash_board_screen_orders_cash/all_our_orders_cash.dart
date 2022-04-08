import 'dart:convert';
import 'dart:math';

import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/all_orders.dart';
import 'package:asmaasuperadmin/Modules/order_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/invoice_header.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/item%20_%20Order.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/itemList.dart';
import 'package:flutter/material.dart';

class OrdersCash extends StatefulWidget {
  const OrdersCash({Key? key}) : super(key: key);

  @override
  _OrdersCashState createState() => _OrdersCashState();
}

class _OrdersCashState extends State<OrdersCash> {
  ShowOrders? showOrders;
  List<Order> ourOrders = [], ourOrders2 = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getOurOrders().then((value) {
      setState(() {
        showOrders = value;
        showOrders?.orders.forEach((element) {
          if(element.invoiceType == 'كاش' ||element.invoiceType == 'جملة' ){
            ourOrders.add(element) ;
            ourOrders2.add(element) ;
          }
        });
        isLoading = true;
      });
    });
  }

  void filterSearch(String query) {
    List<Order> dummyData = ourOrders2;
    if (query.isNotEmpty) {
      List<Order> resultSearchProduct = [];
      for (int x = 0; x < dummyData.length; x++) {
        if (dummyData[x]
            .name
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }else  if (dummyData[x]
            .phone
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }
      }
      setState(() {
        ourOrders = resultSearchProduct;
      });
      return;
    } else {
      setState(() {
        ourOrders = [];
        ourOrders = ourOrders2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isLoading
        ? Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: SizeConfig.screenWidth!,
          height: SizeConfig.screenHeight!,
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (v){
                    if(v.isEmpty){
                      setState(() {
                        ourOrders = ourOrders2;
                      });
                    }else{
                      filterSearch(v);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'بحث بإسم العميل أو رقم هاتف العميل ',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),

                  ),

                ),
              ),
            ourOrders.isEmpty? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('لا يوجد أي طلبات متاحة الآن')
                ],
              ),
            ): Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: ourOrders.isEmpty ? 0 : ourOrders.length,
                    itemBuilder: (context, index) {
                      return OrderItem(orders: ourOrders[index]);
                    }),
              ),
            ),
          ],)
        ),
      ),
    )
        : Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          Text('إنتظر جاري تجهيز الطلبات')
        ],
      ),
    );
  }
}
