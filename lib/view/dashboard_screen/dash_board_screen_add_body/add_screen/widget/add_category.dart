import 'package:flutter/material.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';


class addCategory extends StatefulWidget {
  const addCategory({Key? key}) : super(key: key);

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
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
                    child: CustomTextFormField(text: 'اسم الصنف')),
              ),
              CustomText(text: 'Amrelgazar.png',color: Colors.grey,),
              SizedBox(height: 10,),
              CustomButton(text: CustomText(text: 'صوره الصنف',), icon: Icon(Icons.add,),onPress: (){},),
              Divider(color: Colors.grey,),
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
                          CustomText(text: 'أسم الصنف',fontSize: 20,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.green,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.red,)),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}