import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginpage/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminPage extends StatefulWidget {
  const adminPage({super.key});
  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  var adminUsername;
  var adminPass;

  //Admin verilerini aldığımız kısım
  Future<void> getAdminValues() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      adminUsername = sp.getString("admin") ?? "Username Not Found";
      adminPass = sp.getString("adminPass") ?? "Password Not Found";
    });
  }

  //çıkış yaparsa tüm verileri backstackten silecek olan fonksiyon
  Future<void> logOut() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("admin");
    sp.remove("adminPass");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

// --AdminPage sayfası açıldığı anda initState ile
//--getAdminValues Fonksiyonu çalışacak. -->initState sayfa açıldığında direk çalıştırır
  @override
  void initState() {
    super.initState();
    getAdminValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Page"),
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
                  "Admin User Name : $adminUsername",
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  "Password: $adminPass",
                  style: TextStyle(fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
