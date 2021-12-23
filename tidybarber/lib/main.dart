import 'package:flutter/material.dart';
import 'package:tidybarber/login_page.dart';
import 'package:tidybarber/pages/welcome.dart';
import 'package:tidybarber/pages/beranda.dart';
import 'package:tidybarber/pages/artikel.dart';
import 'package:tidybarber/pages/pesan.dart';
import 'package:tidybarber/pages/profil.dart';

void main() {
  runApp(Barber());
}

class Barber extends StatelessWidget {
  Barber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/welcome': (context) => Welcome(),
        '/main': (context) => Main(),
        '/artikel': (context) => Artikel(),
        '/pesan': (context) => Pesan(),
        '/profil': (context) => Profile(),
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final tabs = [
    Beranda(),
    Pesan(),
    Artikel(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 63, 104, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 63, 104, 1),
        title: Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: Row(
              children: const <Widget>[
                Flexible(
                  flex: 12,
                  child: TextField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromRGBO(11, 63, 104, 1),
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: 'Search',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                    ))
              ],
            )),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(11, 63, 104, 1),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text('Beranda')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.white,
              ),
              title: Text('Pesan')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.article,
                color: Colors.white,
              ),
              title: Text('Artikel')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text('Profil')),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
