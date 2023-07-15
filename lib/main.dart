import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> authenticateUser(BuildContext context) async {
    bool isAuthenticated = false;
    try {
      // Barmoq izidan foydalanishni tekshirish.
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Kirish uchun barmoq izingizni joylashtiring.',
      );
      // Autentifikatsiya muvaffaqiyatli bo'lganini aytish.
      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IkkinchiSahifa(),
          ),
        );
      }
    } catch (e) {
      // Xatolik yuz berdi
      print(e);
    }
    return isAuthenticated;
  }

  @override
  Widget build(BuildContext context) {
    authenticateUser(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Barmoq izi"),
          onPressed: () => authenticateUser(context),
        ),
      ),
    );
  }
}

class IkkinchiSahifa extends StatelessWidget {
  const IkkinchiSahifa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ikkinchi sahifa"),
      ),
      body: Center(
        child: Text("Auth muvafaqiyatli o'ttiz"),
      ),
    );
  }
}
