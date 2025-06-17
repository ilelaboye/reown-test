import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reown_test/viewmodels/auth.dart';
import 'package:reown_test/views/auth/login.dart';
import 'package:reown_test/views/auth/signup.dart';
import 'package:reown_test/core/extensions.dart';
import 'package:reown_test/views/dashboard/dashboard.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
    });
  }

  void getUser({loader = false}) async {
    final authVm =
        await Provider.of<AuthViewModel>(context, listen: false).getUser();
    if (authVm != null) {
      context.push(Dashboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF9EFD8),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/1.png",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Hey!',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Welcome to GChat',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(fontSize: 14),
                      ),
                      onPressed: () => context.push(Signup()),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account',
                        style: GoogleFonts.roboto().copyWith(fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => context.push(Login()),
                        child: Text(
                          'Login',
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
    );
  }
}
