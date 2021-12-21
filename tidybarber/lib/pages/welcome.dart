import 'package:flutter/material.dart';
import 'package:tidybarber/main.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(image: AssetImage('assets/welcomeImage.png')),
          const SizedBox(height: 25.0),
          const Text(
            'Halo, rekan barber',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Gilory'),
          ),
          const SizedBox(height: 25.0),
          const Text(
            'Selamat datang di aplikasi barber Tidy Hair Barbershop',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'Gilory-1'),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => Main(),
                  ),
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              },
              child: Text(
                "Oke".toString(),
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  primary: const Color.fromRGBO(11, 63, 104, 50),
                  fixedSize: Size(300, 30)))
        ],
      ),
    );
  }
}
