import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/login_dao.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/widget/login_register/login_effect.dart';
import 'package:bt_bili/widget/login_register/login_input.dart';
import 'package:flutter/material.dart';

import '../widget/login_register/login_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = "";
  String passWord = "";
  String rePassWord = "";
  String imoocId = "";
  String orderIdd = "";
  bool protect = false;
  bool loginEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("注册")),
      body: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChange: (text) {
              userName = text;
              _checkInput();
            },
          ),
          LoginInput(
            title: "密码",
            hint: "请输入密码",
            obscureText: true,
            onChange: (text) {
              passWord = text;
              _checkInput();
            },
            onFocusChange: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            title: "确认密码",
            hint: "请重新输入密码",
            obscureText: true,
            onChange: (text) {
              rePassWord = text;
              _checkInput();
            },
            onFocusChange: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            title: "慕课网ID",
            hint: "请输入慕课网ID",
            onChange: (text) {
              imoocId = text;
              _checkInput();
            },
          ),
          LoginInput(
            title: "课程订单号",
            hint: "请输入订单号",
            onChange: (text) {
              orderIdd = text;
              _checkInput();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: LoginButton(
              title: "注册",
              enable: loginEnable,
              onPressed: () {
                _register(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _checkInput() {
    bool enable;
    if (userName.isNotEmpty &&
        passWord.isNotEmpty &&
        rePassWord.isNotEmpty &&
        imoocId.isNotEmpty &&
        orderIdd.isNotEmpty) {
      enable = true;
    } else {
      enable = false;
    }
    if (enable != loginEnable) {
      setState(() {
        loginEnable = enable;
      });
    }
  }

  void _register(BuildContext context) async {
    try {
      var result = await LoginDao.register(
        userName,
        passWord,
        imoocId,
        orderIdd,
      );
      if (result["code"] == 0) {
        showToast("注册成功");
        Navigator.of(context).pop();
      } else {
        showWarnToast(result["msg"]);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on BtNetError catch (e) {
      showWarnToast(e.message);
    }
  }
}
