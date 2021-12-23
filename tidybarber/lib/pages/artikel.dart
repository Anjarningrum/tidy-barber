import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tidybarber/network/api.dart';
import 'package:tidybarber/pages/artikel.dart';

class Artikel extends StatefulWidget {
  const Artikel({Key? key}) : super(key: key);

  @override
  State<Artikel> createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  Future<dynamic> _fecthDataUsers() async {
    var result = await Network().getData('profil');
    var body = json.decode(result.body);
    return body;
  }

  Future<List<dynamic>> _topArtikel() async {
    var result = await Network().getData('artikel');
    var body = json.decode(result.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 63, 104, 1),
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
                          Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 5.0, 0, 0),
                                    child: Text(
                                      'Hello, ${snapshot.data['name']}',
                                      style: const TextStyle(
                                          fontSize: 29, color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                                    child: Text(
                                      'Artikel Pilihan Untukmu !',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: FutureBuilder<List<dynamic>>(
                  future: _topArtikel(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // if you need this
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            margin: EdgeInsets.all(4),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: 125.0,
                              height: 60.0,
                              child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(snapshot.data[index]['judul'])),
                            ),
                          );
                        },
                      ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
