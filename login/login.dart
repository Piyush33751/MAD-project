import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../classDatabase.dart';

import 'register.dart';
import '../mapdatabse.dart';
import '../userdataservice.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLocalizationBloc, AppLocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('zh')],
          debugShowCheckedModeBanner: false,
          title: 'Login',
          theme: ThemeData(
            primarySwatch: Colors.red,
            inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          locale: state.locale,
          home: Login(),
        );
      },
    );
  }
}

class AppLocalizationState {
  final Locale locale;
  const AppLocalizationState(this.locale);
}

abstract class AppLocalizationEvent {}

class SetLocale extends AppLocalizationEvent {
  final Locale locale;
  SetLocale({required this.locale});
}

class AppLocalizationBloc
    extends Bloc<AppLocalizationEvent, AppLocalizationState> {
  AppLocalizationBloc() : super(const AppLocalizationState(Locale('en'))) {
    on<SetLocale>((event, emit) => emit(AppLocalizationState(event.locale)));
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  var blockNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserDataService.getAllUser();
  }

  void login() async {
    await UserDataService.getAllUser();

    bool userFound = false;
    for (var user in UserDataService.z) {
      if (user.email == email.text.trim() &&
          user.password == password.text.trim() &&
          user.blkno == blockNumber.text.trim()) {
        userFound = true;
        break;
      }
    }

    if (userFound) {
      Reports.loginbuild = blockNumber.text;
      Mapdatabse.loginbuild = blockNumber.text;
      await Reports.buildingsorter();
      await Mapdatabse.buildingsorter();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      var loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.invalidLoginCredentials)),
      );
    }
  }

  void showLanguageDialog() {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(loc.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text(loc.english),
                onPressed: () {
                  context
                      .read<AppLocalizationBloc>()
                      .add(SetLocale(locale: const Locale('en')));
                  Navigator.pop(dialogContext);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: Text(loc.chinese),
                onPressed: () {
                  context
                      .read<AppLocalizationBloc>()
                      .add(SetLocale(locale: const Locale('zh')));
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/images/download.svg",
                          height: 100),
                      const SizedBox(height: 20),
                      Text(loc.login,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: loc.email,
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                          labelText: loc.password,
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: blockNumber,
                        decoration: InputDecoration(
                          labelText: loc.hdbBlockNumber,
                          prefixIcon: const Icon(Icons.home),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(loc.login,
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage())),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(loc.register,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Image.asset("assets/images/hdblogo.png",
                width: 100, height: 100),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.language, size: 30),
              onPressed: showLanguageDialog,
            ),
          ),
        ],
      ),
    );
  }
}
