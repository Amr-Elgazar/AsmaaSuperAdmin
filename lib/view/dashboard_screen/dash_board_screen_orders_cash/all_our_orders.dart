import 'dart:convert';

import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/all_orders.dart';
import 'package:asmaasuperadmin/Modules/order_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/invoice_header.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/item%20_%20Order.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_orders_cash/widgets/itemList.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  ShowOrders? showOrders;
  List<Order> ourOrders = [], ourOrders2 = [];
  List<String> time = ['جميع التواريخ'] , time2=[];
  String timeSelected= 'جميع التواريخ';
  bool isLoading = false;
  double total = 0.0,amountPaid = 0.0 , total2 = 0.0 , amountPaid2 = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getOurOrders().then((value) {
      setState(() {
        showOrders = value;
        ourOrders = showOrders!.orders;
        ourOrders2 = showOrders!.orders;
        ourOrders2.forEach((element) {
          if(!time.contains(element.created_at)){
            time.add(element.created_at);
            time2 = time;
          }
          total += double.parse(element.total);
          amountPaid += double.parse(element.amountPaid);
          total2 += double.parse(element.total);
          amountPaid2 += double.parse(element.amountPaid);
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
          setState(() {
            total = 0.0;
            amountPaid = 0.0 ;
            total += double.parse(dummyData[x].total);
            amountPaid += double.parse(dummyData[x].amountPaid);
          });

        }else if (dummyData[x]
            .phone
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {

          resultSearchProduct.add(dummyData[x]);
          setState(() {
            total = 0.0;
            amountPaid = 0.0 ;
            total += double.parse(dummyData[x].total);
            amountPaid += double.parse(dummyData[x].amountPaid);
          });

        }else if (dummyData[x]
            .created_at
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
          setState(() {
            total = 0.0;
            amountPaid = 0.0 ;
            total += double.parse(dummyData[x].total);
            amountPaid += double.parse(dummyData[x].amountPaid);
          });
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

        total = total2;
        amountPaid = amountPaid2 ;


      });
    }
  }

  void filterTime(String query) {
    List<String> dummyData = time;
    if (query.isNotEmpty) {
      List<String> resultSearchProduct = [];
      for (int x = 0; x < dummyData.length; x++) {
        if (dummyData[x]
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);

        }
      }
      setState(() {
        time = resultSearchProduct;
      });
      return;
    } else {
      setState(() {
        time = [];
        time = time2;
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
                          labelText: 'بحث بإسم العميل أو الضامن رقم هاتف العميل أو الضامن',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search),

                        ),

                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: SizeConfig.screenWidth! * 0.5,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          selectedItem: timeSelected,
                          items: time,
                          hint: timeSelected,
                          showSearchBox: true,
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: (s){
                            if('جميع التواريخ' == s){
                              ourOrders=[];
                              ourOrders = ourOrders2;
                              setState(() {
                                total = total2;
                                amountPaid = amountPaid2 ;
                              });

                            }else {
                              filterSearch(s!);
                            }
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('مبيعات اليوم : $total'),
                        Text('المحصل  : $amountPaid'),
                        Text('المتبقي : ${total-amountPaid}'),
                      ],),
                    ourOrders.isEmpty? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('لا يوجد أي طلبات متاحة الآن')
                        ],
                      ),
                    ): Expanded(
                      child: ListView.builder(
                          itemCount: ourOrders.isEmpty ? 0 : ourOrders.length,
                          itemBuilder: (context, index) {

                            return OrderItem(orders: ourOrders[index]);
                          }),
                    ),
                  ],
                )
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
