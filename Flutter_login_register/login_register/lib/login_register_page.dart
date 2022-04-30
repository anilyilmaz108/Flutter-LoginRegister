import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/home_page.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  Future _login() async {
    var url = "http://10.0.2.2:8005/flutter-login-signup/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": _emailController?.text,
      "password": _passwordController?.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      print('Login Successful');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);
    } else {
      print('Username and password invalid');
    }
  }
  Future _register() async {
    var url = "http://10.0.2.2:8005/flutter-login-signup/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": _emailController?.text,
      "password": _passwordController?.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      print('User allready exit!');
    } else {
      print('Registration Successful');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);
    }
  }
  bool _obscure = true;
  void _toggle() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  final _signInFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login - Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _signInFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 0.2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value){},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "E-Mail",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordController,
                                validator: (value){},
                                obscureText: _obscure,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: _obscure == true ? Colors.grey : Colors.pink,
                                        ),
                                        onPressed: _toggle
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.indigo.shade200,
                                    ]
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, 50)),
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                  // elevation: MaterialStateProperty.all(3),
                                  shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: ()async{
                                  _login();
                                },
                                child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Colors.pinkAccent,
                                    ]
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, 50)),
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                  // elevation: MaterialStateProperty.all(3),
                                  shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: ()async{
                                  _register();
                                },
                                child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
