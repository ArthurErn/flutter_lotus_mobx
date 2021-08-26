import 'package:flutter/material.dart';

class LogoHomePage extends StatelessWidget {
  const LogoHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * .24,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/images/logo_azul.png"),
                fit: BoxFit.fill)),
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .12, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
