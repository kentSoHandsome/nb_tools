import 'package:flutter/material.dart';

import 'Aes/AesWidget.dart';
import 'json_to_dart/json_to_dart_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '工具类集合 for flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget rightWidget = Center(
    child: Text(
      '欢迎来到kent的工具类集合 for flutter',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.pink.shade300,
      ),
    ),
  );

  final menuList = [
    {"title": 'JSON To Dart', 'widget': const JsonToDartWidget()},
    {
      "title": 'JSON To Swift',
      'widget': Center(
        child: Text(
          '别做梦了，iOS开发没前途了。',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade300,
          ),
        ),
      )
    },
    {
      "title": 'JSON To Go',
      'widget': Center(
        child: Text(
          '代码给你，你来写~',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade300,
          ),
        ),
      )
    },
    {"title": 'AES 解密', 'widget': const AesWidget()},
    {
      "title": 'AI 编程',
      'widget': Center(
        child: Text(
          '敬请期待~',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade300,
          ),
        ),
      )
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 240,
            color: Colors.blue.shade200,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 40,
                  child: const Center(
                    child: Text(
                      '顶级菜单栏',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ...menuList.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 40,
                    color: Colors.blue.shade100,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            rightWidget = item['widget'] as Widget;
                          });
                        },
                        child: Center(
                          child: Text(
                            item["title"].toString(),
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: rightWidget,
          ),
        ],
      ),
    );
  }
}
