import 'package:flutter/material.dart';
import 'package:loginpage/admin.dart';
import 'package:loginpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//kullanıcı var/yok kontrol fonskiyonu
  Future<bool> userCheck() async {
    var sp = await SharedPreferences.getInstance();

    //getString ile var olan username-password alındı
    var usernameCheck = sp.getString("username") ?? "Username Not Found";
    var passwordCheck = sp.getString("password") ?? "Password Not Found";

    //eğer username-password doğru ise mainpage değilse login page
    //gitmek için kontrol bloğu
    if (usernameCheck == "Admin" && passwordCheck == "12345") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //Usercheck fonk. ile eğer kullanıcı varsa Main Page yoksa Login Page gidecek
      home: FutureBuilder<bool>(
        future: userCheck(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //eğer snapshot ile veri (true/false) geldiyse --> True-->MainPage/False-->LoginPage
            bool boolValue = snapshot.hasData;
            return boolValue ? MainPage() : LoginPage();
          } else {
            return const Text("Data Has Not Found");
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var tfUserName = TextEditingController(); //textFieldları kullanmak için
  var tfPassword = TextEditingController(); //TextEditingController oluşturduk

  var scafkey =
      GlobalKey<ScaffoldState>(); //SnackBar kullanmak için key oluşturduk

  Future<void> login() async {
    if (tfUserName.text == "User" && tfPassword.text == "12345") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("username", tfUserName.text);
      sp.setString("password", tfPassword.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect Information"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: tfUserName,
                  decoration: InputDecoration(
                    hintText: "Enter User Name",
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: tfPassword,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                  ),
                ),
                ElevatedButton(
                  child: Text("Log In"),
                  onPressed: () {
                    login(); //future fonksiyon
                  },
                ),
                ElevatedButton(
                  child: Text("Go To Admin Page"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => adminLoginPage()));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
