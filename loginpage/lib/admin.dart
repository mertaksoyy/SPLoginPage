import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginpage/adminpage.dart';
import 'package:loginpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminLoginPage extends StatefulWidget {
  const adminLoginPage({super.key});
  @override
  State<adminLoginPage> createState() => _adminLoginPageState();
}

class _adminLoginPageState extends State<adminLoginPage> {
  var adminName = TextEditingController();
  var adminPassword = TextEditingController();

  Future<void> loginAdmin() async {
    if (adminName.text == "Admin" && adminPassword.text == "12345") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("admin", adminName.text);
      sp.setString("adminPass", adminPassword.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => adminPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect Information for Admin "),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Page"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: adminName,
                  decoration: InputDecoration(
                    hintText: "Enter Admin Name",
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: adminPassword,
                  decoration: InputDecoration(
                    hintText: "Enter Admin Password",
                  ),
                ),
                ElevatedButton(
                  child: Text("Log In"),
                  onPressed: () {
                    loginAdmin(); //future fonksiyon
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
