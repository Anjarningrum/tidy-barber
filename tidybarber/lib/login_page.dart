import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tidybarber/pages/welcome.dart';
import 'network/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    var data = {'email': emailController.text, 'password': passController.text};

    var res = await Network().auth(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //
      if (localStorage.getString('token') != null) {
        await localStorage.clear();
      }
      localStorage.setString('token', body['token']);
      localStorage.setInt('id', body['id']);
      localStorage.setString('name', body['name']);
      localStorage.setString('email', body['email']);
      localStorage.setString('alamat', body['alamat']);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Welcome()));
    } else {
      _showMsg(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 90.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final field = Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: "Logo",
            child: Image.asset('assets/logo.png'),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            obscureText: true,
            controller: passController,
            decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              _login();
            },
            child: Text("Masuk".toString()),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                primary: const Color.fromRGBO(11, 63, 104, 50),
                fixedSize: Size(500, 30)),
          ),
          TextButton(
            child: const Text(
              'Belum Punya akun?',
              style: TextStyle(color: Colors.black54),
            ),
            onPressed: () {
              _login();
            },
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[field],
        ),
      ),
    );
  }
}
