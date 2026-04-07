import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/login_dao.dart';
import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/navigator/bt_routes.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/widget/login_register/login_button.dart';
import 'package:bt_bili/widget/login_register/login_effect.dart';
import 'package:bt_bili/widget/login_register/login_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;

  String userName = "";
  String passWord = "";

  late var listener;

  @override
  void initState() {
    super.initState();
    listener = BtNavigator.getInstance().registerStatePage(
      widget,
      onResue: () {
        print("登陆界面显示");
      },
      onPause: () {
        print("登陆界面消失");
      },
    );
  }

  @override
  void dispose() {
    BtNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("密码登陆"),
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              child: Text(
                "注册",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              BtNavigator.getInstance().onJumpTo(RouterStatus.register);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChange: (value) {
              userName = value;
              checkInput();
            },
          ),
          LoginInput(
            title: "密码",
            hint: "请输入密码",
            obscureText: true,
            onChange: (value) {
              passWord = value;
              checkInput();
            },
            onFocusChange: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 40),
            child: LoginButton(
              title: "登陆",
              enable: loginEnable,
              onPressed: () {
                _login();
              },
            ),
          ),
        ],
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (userName.isNotEmpty && passWord.isNotEmpty) {
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

  void _login() async {
    try {
      EasyLoading.show(status: "loading...");
      var result = await LoginDao.login(userName, passWord);
      EasyLoading.dismiss();
      if (result["code"] == 0) {
        showToast("登录成功");
        BtNavigator.getInstance().onJumpTo(RouterStatus.home);
      } else {
        showWarnToast(result["msg"]);
      }
    } on NeedAuth catch (e) {
      EasyLoading.dismiss();
      showWarnToast(e.message);
    } on BtNetError catch (e) {
      EasyLoading.dismiss();
      showWarnToast(e.message);
    }
  }
}
