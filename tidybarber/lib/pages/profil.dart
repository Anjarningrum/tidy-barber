import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tidybarber/network/api.dart';
import 'package:tidybarber/pages/data_akun.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<dynamic> _fecthDataUsers() async {
    var result = await Network().getData('profil');
    var body = json.decode(result.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder<dynamic>(
                future: _fecthDataUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 400,
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/imagebarber/${snapshot.data['name']}.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 140,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    "Hi,",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    '${snapshot.data['name']}',
                                    style: TextStyle(
                                        fontSize: 29, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    child: const ListTile(
                                      leading:
                                          Icon(Icons.shopping_bag, size: 50),
                                      title: Text('Riwayat Transaksi'),
                                    ),
                                  ),
                                  Card(
                                    child: const ListTile(
                                      leading: Icon(Icons.money, size: 50),
                                      title: Text('Pendapatan'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  DataAkun()));
                                    },
                                    child: Card(
                                      child: const ListTile(
                                        leading: Icon(Icons.account_circle,
                                            size: 50),
                                        title: Text('Data Akun'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ));
  }
}
