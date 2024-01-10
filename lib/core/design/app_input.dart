import 'package:flutter/material.dart';

import 'app_image.dart';

class AppInput extends StatefulWidget {
  final String hintText, icon;
  final bool isPhone, isPassword, isEnabled;
  final double paddingBottom, paddingTop;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final TextInputType? isText;

  const AppInput(
      {Key? key,
      this.controller,
      this.validator,
      this.isEnabled = true,
      this.isPassword = false,
      this.paddingTop = 0,
      this.paddingBottom = 16,
      this.isPhone = false,
        this.icon="",
      required this.hintText, this.isText ,})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingBottom, top: widget.paddingTop),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isPasswordHidden && widget.isPassword,
        enabled: widget.isEnabled,
        keyboardType: widget.isText,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    isPasswordHidden = !isPasswordHidden;
                    setState(() {});
                  },
                )
              : null,
          icon: widget.isPhone
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xffF3F3F3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/ksa.png",
                        width: 32,
                        height: 20,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "+966",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4C8613),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: AppImage(
              path: widget.icon,
              fit: BoxFit.scaleDown,
              width: 20,
              height: 18,
            ),
          ),
        ),
      ),
    );
  }
}
