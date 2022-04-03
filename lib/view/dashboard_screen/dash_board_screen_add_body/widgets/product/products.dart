import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/products_model.dart';
import 'package:asmaasuperadmin/Modules/section_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/widgets/product/widgets/header_product.dart';
import 'package:asmaasuperadmin/view/dashboard_screen/dash_board_screen_add_body/widgets/product/widgets/products_body.dart';
import 'package:flutter/material.dart';

class ProductsData extends StatefulWidget {
  const ProductsData({Key? key}) : super(key: key);

  @override
  State<ProductsData> createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  bool loading = true;
  List<Sections> sections = [];
  List<Products> products = [];
  int possition = 0;

  @override
  void initState() {
    super.initState();
    ServData.getSections().then((value) {
      setState(() {
        sections = value;
      });
    }).whenComplete(() {
      ServData.getProducts().then((value) {
        setState(() {
          products = value;
        });
      }).whenComplete(() => setState(() {
            loading = false;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: loading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  Text('إنتظر جاري تجهيز المنتجات')
                ],
              ),
            )
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Text(
                        'الأقسام',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight! * 0.01),
                      width: SizeConfig.screenWidth!,
                      height: SizeConfig.screenHeight! * 0.05,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                loading = true;
                                possition = index;
                              });
                            },
                            child: Container(
                              width: SizeConfig.screenWidth! * 0.1,
                              height: SizeConfig.screenHeight! * 0.5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.005,
                                  vertical: SizeConfig.screenHeight! * 0.003),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(sections[index].name,
                                      style:
                                          const TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: sections.isEmpty ? 0 : sections.length,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemHeader(),
                    Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight! * 0.01),
                      width: SizeConfig.screenWidth!,
                      height: SizeConfig.screenHeight! * 0.5,
                      child: ListView.builder(
                          itemCount: products.isEmpty ? 0 : products.length,
                          itemBuilder: (context, index) => ItemBody(
                                name: products[index].name,
                                id: products[index].productCode,
                                installmentPrice: products[index].installmentPrice,
                                selling: products[index].sellingPrice,
                                wholesale: products[index].wholesalePrice,
                                quantity: products[index].productNum,
                              )),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
