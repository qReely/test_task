import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool emailActive = false;
  bool passActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      setState(() {
        emailActive = emailController.text.isNotEmpty;
      });
    });
    passwordController.addListener(() {
      setState(() {
        passActive = passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showTitle = MediaQuery.of(context).viewInsets.bottom == 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(image: const AssetImage("assets/background.png"), fit: BoxFit.fitHeight, width: MediaQuery.of(context).size.width),
          Transform.scale(
            scaleY: -1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 310),
              child: ClipPath(
                clipper: DiagonalPathClipperOne(),
                child: Container(
                  color: const Color.fromRGBO(196, 196, 196, 1),
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Visibility(
                      visible: showTitle,
                      child: const Text(
                        "Вход",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 2.25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(2, 28, 96, 0.2),
                              blurRadius: 16,
                              spreadRadius: 10,
                            )
                          ]),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 60),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 16),
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                ),
                              ),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(fontSize: 16),
                                obscureText: true,
                                obscuringCharacter: '●',
                                decoration: const InputDecoration(
                                  // border: ,
                                  labelText: "Пароль",
                                ),
                              ),
                              MaterialButton(
                                disabledColor: const Color.fromRGBO(155, 81, 224, 0.6),
                                color: const Color.fromRGBO(155, 81, 224, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                minWidth: 240,
                                height: 40,
                                onPressed:
                                    (emailActive && passActive) ? () {
                                      Navigator.pushNamed(context, "/users");
                                    } : null,
                                child: const Text(
                                  "Войти",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
