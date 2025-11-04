/*
 * @Author: zhang
 * @Date: 2020-06-20 08:22:01
 * @LastEditTime: 2020-09-05 13:51:58
 * @FilePath: /welterstock/lib/ui/index.dart
 * 主界面生成代码
 */ 
import 'package:welterstock/ui/choice.dart';
import 'package:welterstock/ui/home.dart';
import 'package:welterstock/ui/market.dart';
import 'package:welterstock/ui/my.dart';
import 'package:welterstock/ui/widgets/index.dart';
import 'package:flutter/material.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<IndexPage> {
  int  selectTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectTabIndex,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.group_work), label: '市场'),
          BottomNavigationBarItem(icon: Icon(Icons.group_work), label: '自选'),
          BottomNavigationBarItem(icon: Icon(Icons.group_work), label: '股票'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        onTap: (index) {
          setState(() {
            selectTabIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: selectTabIndex,
        children: [
          HomePage(),  //主页
          MarketPage(),
          ChoicePage(),
          StockIndex(),
          MyPage(),
        ],
      ),
    );
      
  }
}

class HomeOther {
}
