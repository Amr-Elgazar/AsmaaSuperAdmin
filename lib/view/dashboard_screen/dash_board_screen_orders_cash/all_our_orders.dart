import 'dart:convert';

import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/all_orders.dart';
import 'package:asmaasuperadmin/Modules/order_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/invoice_header.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/itemList.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  ShowOrders? showOrders;
  List<Order> ourOrders = [];
  bool isTapped4 = true, isExpanded4 = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getOurOrders().then((value) {
      setState(() {
        showOrders = value;
        ourOrders = showOrders!.orders;
        isLoading = true;
      });
    });
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
                child: ListView.builder(
                    itemCount: ourOrders.isEmpty ? 0 : ourOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, right: 10.0, left: 10.0),
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: isTapped4
                              ? isExpanded4
                                  ? 100
                                  : 100
                              : isExpanded4
                                  ? 225
                                  : 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue, // set border color
                                width: 1.0), // set border width
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            // set rounded corner radius
                          ),
                          child: isTapped4
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isTapped4 = !isTapped4;
                                            });
                                          },
                                          icon: Icon(
                                            isTapped4
                                                ? Icons.keyboard_arrow_down
                                                : Icons.keyboard_arrow_up,
                                            color: Colors.blue,
                                            size: 27,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text('الإسم : ' +
                                                  ourOrders[index].name)),
                                          Expanded(
                                              child: Text('رقم الهاتف : ' +
                                                  ourOrders[index].phone)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text('عدد المنتجات : ' +
                                                  ourOrders[index].productNum)),
                                          Expanded(
                                              child: Text('نوع الفاتورة : ' +
                                                  ourOrders[index]
                                                      .invoiceType)),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isTapped4 = !isTapped4;
                                            });
                                          },
                                          icon: Icon(
                                            isTapped4
                                                ? Icons.keyboard_arrow_down
                                                : Icons.keyboard_arrow_up,
                                            color: Colors.blue,
                                            size: 27,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text('الإسم : ' +
                                                  ourOrders[index].name)),
                                          Expanded(
                                              child: Text('رقم الهاتف : ' +
                                                  ourOrders[index].phone)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text('عدد المنتجات : ' +
                                                  ourOrders[index].productNum)),
                                          Expanded(
                                              child: Text('نوع الفاتورة : ' +
                                                  ourOrders[index]
                                                      .invoiceType)),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: InvoiceHeader(
                                            invoiceType:
                                                ourOrders[index].invoiceType),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.screenWidth,
                                          height:
                                              SizeConfig.screenHeight! * 0.2,
                                          child: ItemList(
                                              products:
                                                  ourOrders[index].products,
                                              qtys: jsonDecode(
                                                  ourOrders[index].qty),
                                              prices: jsonDecode(
                                                  ourOrders[index].prices))),
                                      Text('إجمالي الفاتورة : ' +
                                          ourOrders[index].total)
                                    ],
                                  ),
                                ),
                        ),
                      );
                    }),
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
