import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_task/users_model.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
  bool _isLoading = true;
  bool _isError = false;
  bool _isNoInternetConnection = false;
  List<User> users = [];

  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  Future getUsers() async {
    setState(() {
      _isLoading = true;
      _isNoInternetConnection = false;
      _isError = false;
    });

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // successfully loaded
        var list = jsonDecode(response.body) as List;
        users = list.map((user) => User.fromJson(user)).toList();
      } else {
        // error
        _isError = true;
      }
    } else {
      // No Internet Connection
      _isError = true;
      _isNoInternetConnection = true;
    }
    setState(() {
      _isLoading = false;
    });
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : (_isError
            ? errorWidget()
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: getAppBar(),
                body: ListView.builder(
                  controller: _scrollController,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return userCard(index);
                  },
                ),
              ));
  }

  AppBar getAppBar(){
    return _scrollPosition == 0
        ? AppBar(
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 100,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Пользователи",
            style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    )
        : AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text(
        "Пользователи",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  Padding userCard(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage('assets/user_circle.png'),
            size: 50,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                users[index].name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                users[index].email,
                style: const TextStyle(
                    fontSize: 13, color: Colors.grey),
              ),
              Text(
                users[index].company['name'],
                style: const TextStyle(fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container errorWidget(){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(image: AssetImage("assets/error.png"), height: 66,),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Не удалось загрузить информацию",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          _isNoInternetConnection
              ? const Text(
            "Проверьте интернет соединение",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none),
          )
              : const SizedBox(
            height: 0,
          ),
          const SizedBox(
            height: 32,
          ),
          MaterialButton(
            color: const Color.fromRGBO(155, 81, 224, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minWidth: 240,
            height: 40,
            onPressed: () {
              setState(() {
                getUsers();
              });
            },
            child: const Text(
              "Обновить",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
