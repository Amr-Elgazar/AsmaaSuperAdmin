import 'dart:convert';
import 'dart:io';

import 'package:asmaasuperadmin/Api/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';

class addbrand extends StatefulWidget {
  const addbrand({Key? key}) : super(key: key);

  @override
  State<addbrand> createState() => _addbrandState();
}

class _addbrandState extends State<addbrand> {
  TextEditingController nameController = TextEditingController();

  bool adding = false;
  String? imageBase64;
  List sections = [], brands = [];
  bool isTapped4 = true, isExpanded4 = false;
  int _radioChooseSections = 0;

  int sectionId = 0, categoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 200,
                    child: CustomTextFormField(
                      text: 'اسم الماركه',
                      controller: nameController,
                    )),
              ),
              CustomText(
                text: 'Amrelgazar.png',
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: CustomText(
                  text: 'صوره الماركه',
                ),
                icon: Icon(
                  Icons.add,
                ),
                onPress: () => chooseImage(),
              ),
              Divider(
                color: Colors.grey,
              ),
              /*
              Column(
                children: [
                  Material(
                    elevation: 10,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(child: Image.asset('assets/logo.jpg'),backgroundColor: Colors.white,radius: 50,),
                          CustomText(text: 'أسم الماركه',fontSize: 20,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.green,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.red,)),
                        ],
                      ),
                    ),
                  )
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }

  void chooseImage() async {
    PickedFile? pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      try {
        setState(() {
          File file = File(pickedFile!.path);
          imageBase64 = base64Encode(file.readAsBytesSync()).toString();
        });
      } catch (e) {
        print(e);
      }
    });
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
          width: isExpanded4 ? 385 : 390,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, // set border color
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
                            'Tap to Select your Scetion  *',
                            style: TextStyle(
                                color: Colors.white,
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
                              color: Colors.white,
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
                            'Select any Section',
                            style: TextStyle(
                                color: Colors.white,
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
                              color: Colors.white,
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
                                index + 1, '${sections[index].name} ');
                          }),
                    )
                  ],
                ),
        ),
      );

  RadioListTile<dynamic> buildRadioChooseSubject(val, txt) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.platform,
      activeColor: Colors.white,
      value: val,
      groupValue: _radioChooseSections,
      onChanged: (value) {
        setState(() {
          _radioChooseSections = value;
        });
      },
      title: Text(
        txt,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onPressed() {
    if (nameController.text.isEmpty) {
    } else {
      setState(() {
        adding = true;
      });
      ServData.addBrands(
        name: nameController.text,
        image: null,
        categoryId: categoryId,
        sectionId: sectionId,
      ).catchError((onError) {
        print(onError);
        setState(() {
          adding = false;
        });
      }).whenComplete(() {
        setState(() {
          adding = false;
        });
      });
    }
  }
}
