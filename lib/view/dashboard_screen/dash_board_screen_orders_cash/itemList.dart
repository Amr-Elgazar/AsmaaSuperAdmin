import 'package:asmaasuperadmin/Modules/products_model.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  List<Products> products = [];
  List qtys = [];
  List prices = [];

  ItemList({Key? key, required this.products , required this.qtys , required this.prices }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: ListView.builder(
            itemCount: widget.products.isEmpty ? 0 : widget.products.length,
            itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CustomText(
                      text:  widget.products[index].name.replaceAll('"', ''),
                      fontSize: 17,
                    )),
                    Expanded(
                        child: CustomText(
                          text: '${int.parse(widget.products[index].productNum.replaceAll('"', ''))}',
                          fontSize: 17,
                        )),
                    Expanded(
                        child: CustomText(
                          text: '    ${widget.prices[index]}',
                          fontSize: 17,
                        )),
                  ],
                ),
              ),


              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: '${widget.qtys[index]}',
                            fontSize: 17,
                          ),
                        )),
                    Expanded(
                        child: CustomText(
                          text: '${widget.qtys[index] *  widget.prices[index]}',
                          fontSize: 17,
                        )),
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}
