import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tidybarber/network/api.dart';

class DataAkun extends StatefulWidget {
  const DataAkun({Key? key}) : super(key: key);

  @override
  _DataAkunState createState() => _DataAkunState();
}

Future<dynamic> _fecthDataUsers() async {
  var result = await Network().getData('profil');
  var body = json.decode(result.body);
  return body;
}

class _DataAkunState extends State<DataAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<dynamic>(
                  future: _fecthDataUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new AssetImage(
                                                      'assets/imagebarber/anjar septia.jpeg')))),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Ganti Photo Profile'),
                                          ));
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                        ),
                                        child: const Text("Ganti Foto"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        initialValue: snapshot.data['name'],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: snapshot.data['name'],
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        initialValue: snapshot.data['email'],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: snapshot.data['email'],
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        initialValue:
                                            snapshot.data['no_telepon'],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: snapshot.data['no_telepon'],
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        initialValue: snapshot.data['alamat'],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: snapshot.data['alamat'],
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('Simpan'),
                                          ));
                                        },
                                        child: Text(
                                          "Simpan".toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            primary: const Color.fromRGBO(
                                                11, 63, 104, 50),
                                            fixedSize: Size(500, 30)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
