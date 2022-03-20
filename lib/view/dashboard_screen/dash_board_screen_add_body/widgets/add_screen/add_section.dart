import 'package:asmaasuperadmin/Api/api.dart';
import 'package:asmaasuperadmin/widgets/custom_button.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AddSection extends StatefulWidget {
  const AddSection({Key? key}) : super(key: key);

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  TextEditingController nameController = TextEditingController();

  String? nameError;

  bool adding = false;

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
                    child:  TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: 'اسم القسم', border: OutlineInputBorder()),
                    ),),
              ),
              const SizedBox(
                height: 20,
              ),

              CustomButton(
                text: CustomText(
                  text: 'إضافة القسم',
                ),
                icon: Icon(
                  Icons.add,
                ),
                onPress: () => onPressed(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    if (nameController.text.isEmpty) {
      print('5555555Upload');
    } else {
      setState(() {
        adding = true;
      });
      ServData.addSections(name: nameController.text).catchError((onError) {
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
