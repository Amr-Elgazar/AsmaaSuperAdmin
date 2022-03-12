
import 'package:asmaasuperadmin/view/dashboard_screen/dashboard_screen.dart';
import 'package:asmaasuperadmin/widgets/custom_button.dart';
import 'package:asmaasuperadmin/widgets/custom_text.dart';
import 'package:asmaasuperadmin/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                  child: const CustomTextFormField(text: 'كلمه السر ؟')),
              const SizedBox(height: 20,),
              CustomButton(
                  text: CustomText(text: 'تسجيل الدخول'),
                  icon: const Icon(Icons.login,),
                onPress: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );},
              )
            ],
          ),
        ),
      ),
    );
  }
}
