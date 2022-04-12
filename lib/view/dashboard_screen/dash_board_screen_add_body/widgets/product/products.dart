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
  List<Products> products = [] , products2 = [];
  int possition = -1;
  String sectionName = 'جميع المنتجات';
  TextEditingController searchController = TextEditingController();

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
          products2 = value;
        });
      }).whenComplete((){ setState(() {
            loading = false;
          });});
    });
  }

  void filterSearch(String query) {
    List<Products> dummyData = products2;
    if (query.isNotEmpty) {
      List<Products> resultSearchProduct = [];
      for (int x = 0; x < dummyData.length; x++) {
        if (dummyData[x]
            .productCode
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }else if (dummyData[x]
            .name
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }
      }
      setState(() {
        products = resultSearchProduct;
      });
      return;
    } else {
      setState(() {
        products = [];
        products = products2;
      });
    }
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          filterSearch(value);
                        },
                        onFieldSubmitted: (v) {
                          filterSearch(v);
                        },
                        decoration: const InputDecoration(
                            labelText: 'إضافه رقم السلعه',
                            border: OutlineInputBorder()),
                      ),
                    ),
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
                              loading=true;
                            });
                              ServData.getProductsForSection(id: sections[index].id).then((value) {
                                  setState(() {
                                  products = value;
                                  loading = false;
                                  possition = index;
                                });

                              });
                            },
                            child: Container(
                              width: SizeConfig.screenWidth! * 0.1,
                              height: SizeConfig.screenHeight! * 0.5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.005,
                                  vertical: SizeConfig.screenHeight! * 0.003),
                              decoration:  BoxDecoration(
                                color:possition == index?Colors.blue.withOpacity(0.65) :Colors.blue,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
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
                     InkWell(
                       onTap: () {
                         setState(() {
                           loading = true;
                           possition =-1;
                         });
                         ServData.getProducts().then((value) {
                           setState(() {
                             products = value;
                             loading = false;
                           });
                         });
                       },
                       child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(
                           sectionName,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                    ),
                     ),
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
                                product: products[index],
                              )),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
