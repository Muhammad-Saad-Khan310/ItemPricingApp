import 'package:flutter/material.dart';
import 'package:shopapp/exception/http_exceptions.dart';
import 'package:shopapp/screens/HomeScreen.dart';

import 'package:shopapp/models/auth.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routrName = 'AuthScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _isLogin = true;
  var _isLoading = false;
  static const fieldColor = Color(0xFFECECEC);

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An Error Occured!"),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (!_isLogin) {
        await Provider.of<Auth>(context, listen: false)
            .signup(_userEmail, _userPassword);
        Navigator.pushReplacementNamed(context, 'homeScreen');
      } else {
        await Provider.of<Auth>(context, listen: false)
            .login(_userEmail, _userPassword);
        Navigator.pushReplacementNamed(context, 'homeScreen');
      }
    } on HttpException catch (error) {
      var errorMessage = "Authenticate failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use.";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is not a valid email.";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak.";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Could not find a user with that email.";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      // This catch block is used to catch that you has network error
      const errorMessage =
          "Could not authenticate you. Please try again later.";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              margin: _isLogin
                  ? const EdgeInsets.only(top: 40)
                  : const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Container(
                      child: !_isLogin
                          ? Column(
                              children: const [
                                Text(
                                  'Create Your Account.',
                                  style: TextStyle(
                                      color: Color(0xff5959C4),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Please enter info to create an account.',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            )
                          : Container()),
                  const SizedBox(
                    height: 45,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_isLogin || _isLogin == false)
                            TextFormField(
                              key: const ValueKey('email'),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Please Enter Vaild Emailadress.";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                labelText: 'Email address',
                                fillColor: fieldColor,
                                filled: true,
                              ),
                              onSaved: (value) {
                                _userEmail = value!;
                              },
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                          // if (!_isLogin)
                          //   TextFormField(
                          //     key: const ValueKey('username'),
                          //     validator: (value) {
                          //       if (value!.isEmpty || value.length < 4) {
                          //         return 'Please Enter at least 4 characters.';
                          //       }
                          //       return null;
                          //     },
                          //     decoration: const InputDecoration(
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(10.0),
                          //         ),
                          //         borderSide: BorderSide(
                          //           width: 0,
                          //           style: BorderStyle.none,
                          //         ),
                          //       ),
                          //       labelText: 'UserName',
                          //       fillColor: fieldColor,
                          //       filled: true,
                          //     ),
                          //     onSaved: (value) {
                          //       _userName = value!;
                          //     },
                          //   ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            key: const ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please Enter at least 7 characters.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                labelText: 'Password',
                                fillColor: fieldColor,
                                filled: true,
                                suffixIcon:
                                    Icon(Icons.remove_red_eye_outlined)),
                            obscureText: true,
                            onSaved: (value) {
                              _userPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      primary: fieldColor,
                                      onPrimary: Colors.black,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      elevation: 0,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  onPressed: () {
                                    _submit();
                                  },
                                  child: Text(
                                    _isLogin ? 'Log In' : 'Register',
                                    style: TextStyle(
                                      color: _isLogin
                                          ? Colors.black
                                          : const Color(0xff5959C4),
                                    ),
                                  ),
                                ),
                          _isLogin
                              ? Container(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Forget Password?',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                )
                              : Container(),
                          const SizedBox(
                            height: 15,
                          ),
                          _isLogin
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('or'),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 15,
                          ),
                          _isLogin
                              ? Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Placeholder(
                                        color: Colors.black,
                                        fallbackHeight: 10,
                                        fallbackWidth: 50,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Placeholder(
                                        color: Colors.black,
                                        fallbackHeight: 10,
                                        fallbackWidth: 50,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Placeholder(
                                        color: Colors.black,
                                        fallbackHeight: 10,
                                        fallbackWidth: 50,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLogin
                                  ? const Text('Need an account?')
                                  : const Text('Already Have An Account?'),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                    },
                                    child: _isLogin
                                        ? const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                color: Color(0xff5959C4)),
                                          )
                                        : const Text(
                                            'Log In',
                                            style: TextStyle(
                                                color: const Color(0xff5959C4)),
                                          )),
                              ),
                            ],
                          )
                        ],
                      )),
                  //TODO: Demo Button
                  // ElevatedButton.icon(
                  //     onPressed: () {
                  //       Navigator.pushReplacementNamed(context, 'homeScreen');
                  //     },
                  //     icon: const Icon(Icons.skip_next_outlined),
                  //     label: const Text('To Home'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
