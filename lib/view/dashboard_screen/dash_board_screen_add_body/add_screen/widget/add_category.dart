import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/Modules/section_model.dart';
import 'package:asmaasuperadmin/utils/core/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';

class addCategory extends StatefulWidget {
  const addCategory({Key? key}) : super(key: key);

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  TextEditingController nameController = TextEditingController();

  bool adding = false;

  List<Sections> sections = [], brands = [];
  bool isTapped4 = true, isExpanded4 = false;
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
      });
    }).whenComplete(() {});
  }

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
                      text: 'اسم الصنف',
                      controller: nameController,
                    )),
              ),
              CustomText(
                text: 'Amrelgazar.png',
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: CustomText(
                  text: 'صوره الصنف',
                ),
                icon: const Icon(
                  Icons.add,
                ),
                onPress: () => chooseImage(),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              buildRadioButtonSubjects(),
              const SizedBox(
                height: 20,
              ),
              Container(
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

  void onPressed() {
    if (nameController.text.isEmpty &&
        imageBase64 == null &&
        _radioChooseSection == 0) {
    } else {
      setState(() {
        adding = true;
      });
      ServData.addCategories(
              name: nameController.text,
              sectionId: sectionId,
              image: imageBase64)
          .whenComplete(() {
        setState(() {
          adding = false;
        });
      });
    }
  }
}
