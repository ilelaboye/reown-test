import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reown_test/core/extensions.dart';
import 'package:reown_test/core/validator.dart';
import 'package:reown_test/theme/input.dart';
import 'package:reown_test/viewmodels/auth.dart';
import 'package:reown_test/views/auth/signup.dart';
import 'package:reown_test/views/dashboard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();

  String email = "lekan@gmail.com";
  String password = "123456";

  void login() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      final auth = Provider.of<AuthViewModel>(context, listen: false);
      try {
        final resp = await auth.login(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green[400],
              content: Text('Login successful!')),
        );
        context.push(Dashboard());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red[400], content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthViewModel>(context).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(-18, 0),
                  child: Icon(
                    Icons.chevron_left_outlined,
                    size: 45,
                  ).onTap(() => context.pop()),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.inter().copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: 300,
                              child: Text(
                                'Login with your existing account',
                                style: TextStyle(fontSize: 14),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: appInputDecoration('Email', context),
                            validator: validateEmail,
                            onSaved: (value) => email = value!,
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            obscureText: true,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: appInputDecoration('Password', context),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            onSaved: (value) => password = value!,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          child: Text(
                            isLoading ? 'LOADING...' : 'LOGIN',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: isLoading ? null : () => {login()},
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: GoogleFonts.roboto().copyWith(fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: (() => context.push(Signup())),
                            child: Text(
                              'Signup',
                              style: GoogleFonts.roboto().copyWith(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      )
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
