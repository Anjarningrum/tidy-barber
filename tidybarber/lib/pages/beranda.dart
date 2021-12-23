import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tidybarber/network/api.dart';
import 'package:tidybarber/pages/artikel.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Network net = new Network();

  Future<dynamic> _fecthDataUsers() async {
    var result = await Network().getData('profil');
    var body = json.decode(result.body);
    return body;
  }

  Future<List<dynamic>> _topArtikel() async {
    var result = await Network().getData('topartikel');
    var body = json.decode(result.body);
    return body;
  }

  Future<dynamic> _previewUlasan() async {
    var result = await Network().getData('ulasanpreview');
    var body = json.decode(result.body);
    return body;
  }

  @override
  void _initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
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
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 20),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/imagebarber/${snapshot.data['name']}.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                                  child: Text(
                                    'Hello, ${snapshot.data['name']}',
                                    style: const TextStyle(
                                        fontSize: 29, color: Colors.white),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                                  child: Text(
                                    'Customer needs you !',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                child: TextButton(
                              child: Image.asset(
                                'assets/imageberanda/pesan.png',
                              ),
                              onPressed: () {},
                            )),
                            Flexible(
                                child: TextButton(
                              child: Image.asset(
                                  'assets/imageberanda/pendapatan.png'),
                              onPressed: () {},
                            )),
                            Flexible(
                                child: TextButton(
                              child: Image.asset(
                                  'assets/imageberanda/riwayatorder.png'),
                              onPressed: () {},
                            )),
                            Flexible(
                                child: TextButton(
                              child: Image.asset(
                                  'assets/imageberanda/artikel.png'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Artikel()));
                              },
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Flexible(
                            child: Container(
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25))),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Text(
                                        "Artikel",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.topCenter),
                                      child: Row(children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          Artikel()));
                                            },
                                            child: Text("Lihat Semua")),
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 125,
                  child: FutureBuilder<List<dynamic>>(
                    future: _topArtikel(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // if you need this
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
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "Ulasan",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.topCenter),
                            child: Row(children: <Widget>[
                              Text("Lihat Semua"),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: 75,
                      child: FutureBuilder(
                          future: _previewUlasan(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shadowColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // if you need this
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(4),
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      height: 60.0,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Text((() {
                                                    if (snapshot.data != null) {
                                                      return "Rating : ${snapshot.data['rating']}";
                                                    } else {
                                                      return "Rating : ";
                                                    }
                                                  })())),
                                              SizedBox(
                                                width: 35,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Text((() {
                                                    if (snapshot.data != null) {
                                                      return "Customer : ${snapshot.data['customer']}";
                                                    } else {
                                                      return "Customer : ";
                                                    }
                                                  })())),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ));
                            } else {
                              return Center();
                            }
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
