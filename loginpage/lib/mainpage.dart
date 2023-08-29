import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginpage/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Kullanıcı için
  var getUsername;
  var getPassword;

  Future<void> getUserValues() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      getUsername = sp.getString("username") ?? "Username Not Found";
      getPassword = sp.getString("password") ?? "Password Not Found";
    });
  }

  //Admin için
  var adminUsername;
  var adminPass;

  Future<void> getAdminValues() async {
    var sp = await SharedPreferences.getInstance();
    adminUsername = sp.getString("admin");
    adminPass = sp.getString("adminPass");
  }

  //çıkış yaparsa tüm verileri backstackten silecek olan fonksiyon
  Future<void> logOut() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("username");
    sp.remove("password");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

// --MainPage sayfası açıldığı anda initState ile
//--getValues Fonksiyonu çalışacak. -->initState sayfa açıldığında direk çalıştırır
  @override
  void initState() {
    super.initState();
    getUserValues();
    getAdminValues();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main Page"),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                logOut();
              },
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Name : $getUsername ",
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  "Password: $getPassword",
                  style: TextStyle(fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
