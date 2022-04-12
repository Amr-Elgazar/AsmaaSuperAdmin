import 'dart:ui';
import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/products_model.dart';
import 'package:asmaasuperadmin/Modules/section_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpdateProduct extends StatefulWidget {
  Products product;

  UpdateProduct({Key? key , required this.product}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController descriptionController  = TextEditingController();
  TextEditingController productNumController    = TextEditingController();
  TextEditingController sellingPriceController   = TextEditingController();
  TextEditingController purchasePriceController  = TextEditingController();
  TextEditingController wholesalePriceController = TextEditingController();
  TextEditingController installmentPriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();

  bool adding = false;

  List<Sections> sections = [], brands = [];
  bool isTapped4 = true, isExpanded4 = false;
  String hintImage = 'لم يتم إختيار صورة';

  int sectionId = 0;

  String? imageBase64;

  int _radioChooseSection = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getSections().then((value) {
      setState(() {
        sections = value;
        sections.forEach((element) {
          if(element.id == widget.product.sectionId){
            nameController.text = widget.product.name;
            sectionController.text = element.name;
            descriptionController.text = widget.product.description;
            productNumController.text = widget.product.productNum;
            sellingPriceController.text = widget.product.sellingPrice;
            purchasePriceController.text = widget.product.purchasePrice;
            wholesalePriceController.text = widget.product.wholesalePrice;
            installmentPriceController.text = widget.product.installmentPrice;
            productCodeController.text = widget.product.productCode;
          }
        });
      });
    }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            labelText: 'اسم الصنف',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            labelText: 'الوصف', border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: productNumController,
                        decoration: const InputDecoration(
                            labelText: 'عدد الصنف',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: purchasePriceController,
                        decoration: const InputDecoration(
                            labelText: 'سعر الشراء من المورد',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: sellingPriceController,
                        decoration: const InputDecoration(
                            labelText: 'سعر البيع للعميل',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: wholesalePriceController,
                        decoration: const InputDecoration(
                            labelText: 'سعر الجملة للعميل',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: installmentPriceController,
                        decoration: const InputDecoration(
                            labelText: 'سعر القسط للعميل',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.4,
                      child: TextFormField(
                        controller: productCodeController,
                        decoration: const InputDecoration(
                            labelText: 'كود الصنف',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: SizeConfig.screenWidth! * 0.4,
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: sectionController,
                    decoration: const InputDecoration(
                        labelText: 'القسم',
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => onPressed(),
                child: Container(
                  height: 60,
                  width: SizeConfig.screenWidth! * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                        color: Colors.blue, // set border color
                        width: 1.0), // set border width
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    // set rounded corner radius
                  ),
                  child: const Center(
                    child: Text(
                      'إضافة صنف',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioButtonSubjects() => Padding(
    padding: const EdgeInsets.only(top: 25.0, right: 10.0, left: 10.0),
    child: AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      height: isTapped4
          ? isExpanded4
          ? 65
          : 70
          : isExpanded4
          ? 225
          : 300,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue, // set border color
            width: 1.0), // set border width
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        // set rounded corner radius
      ),
      child: isTapped4
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'إختيار قسم',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
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
              ],
            ),
          ),
        ],
      )
          : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'قم بإختيار القسم الذي تريده',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
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
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: sections.isEmpty ? 0 : sections.length,
                itemBuilder: (context, index) {
                  return buildRadioChooseSubject(
                      index + 1, '${sections[index].name}');
                }),
          ),
        ],
      ),
    ),
  );

  RadioListTile<dynamic> buildRadioChooseSubject(val, txt) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.platform,
      activeColor: Colors.blue,
      value: val,
      groupValue: _radioChooseSection,
      onChanged: (value) {
        setState(() {
          _radioChooseSection = value;
          sectionId = int.parse(sections[value - 1].id);
        });
      },
      title: Text(
        txt,
        style: const TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onPressed() {
    if (nameController.text.isEmpty &&
        productNumController.text.isEmpty &&
        purchasePriceController.text.isEmpty &&
        sellingPriceController.text.isEmpty &&
        wholesalePriceController.text.isEmpty &&
        installmentPriceController.text.isEmpty &&
        productCodeController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال جميع البيانات', 'إضافة صنف', context);
    } else if (nameController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال إسم الصنف', 'إضافة صنف', context);
    } else if (productNumController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال عدد الصنف بالمخزن', 'إضافة صنف', context);
    } else if (purchasePriceController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال سعر الشراء من المورد', 'إضافة صنف', context);
    } else if (sellingPriceController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال سعر البيع للعميل', 'إضافة صنف', context);
    } else if (wholesalePriceController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال سعر الجملة للعميل', 'إضافة صنف', context);
    } else if (installmentPriceController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال سعر القسط للعميل', 'إضافة صنف', context);
    } else if (productCodeController.text.isEmpty) {
      _showErrorDialog('من فضلك قم بإدخال كود الصنف', 'إضافة صنف', context);
    } else {
      if(descriptionController.text.isEmpty) {
        setState(() {
          adding = true;
        });
        ServData.updateCategories(
          id: widget.product.id,
          name: nameController.text,
          description:descriptionController.text,
          productNum:productNumController.text,
          sellingPrice:sellingPriceController.text,
          purchasePrice:purchasePriceController.text,
          wholesalePrice:wholesalePriceController.text,
          installmentPrice: installmentPriceController.text,
          productCode:productCodeController.text,
          sectionId:  int.parse(widget.product.sectionId),
        ).whenComplete(() {
          _showSuccessDialog(context , 'تم تعديل الصنف بنجاح');
          setState(() {
            adding = false;
            _radioChooseSection = 0;
            nameController.clear();
            productNumController.clear();
            sellingPriceController.clear();
            purchasePriceController.clear();
            wholesalePriceController.clear();
            installmentPriceController.clear();
            productCodeController.clear();
          });
        });
      }else{
        setState(() {
          adding = true;
        });
        ServData.updateCategories(
          id: widget.product.id,
          name: nameController.text,
          description: descriptionController.text,
          productNum: productNumController.text,
          sellingPrice: sellingPriceController.text,
          purchasePrice: purchasePriceController.text,
          wholesalePrice: wholesalePriceController.text,
          installmentPrice: installmentPriceController.text,
          productCode: productCodeController.text,
          sectionId: int.parse(widget.product.sectionId),
        ).whenComplete(() {
          _showSuccessDialog(context , 'تمت تعديل الصنف بنجاح');
          setState(() {
            adding = false;
            _radioChooseSection = 0;
            nameController.clear();
            _radioChooseSection = 0;
            nameController.clear();
            productNumController.clear();
            sellingPriceController.clear();
            purchasePriceController.clear();
            wholesalePriceController.clear();
            installmentPriceController.clear();
            productCodeController.clear();
            descriptionController.clear();
          });
        });
      }
    }
  }

  void _showSuccessDialog(BuildContext context , String message) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        title: 'تعديل الصنف',
        desc: message,
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {

        }).show();
  }

  void _showErrorDialog(String message, String title, BuildContext context) {

    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: title,
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red).show();

  }

}
