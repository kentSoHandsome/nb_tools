import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

import 'model_generator.dart';

class JsonToDartWidget extends StatefulWidget {
  const JsonToDartWidget({super.key});

  @override
  State<JsonToDartWidget> createState() => _JsonToDartWidgetState();
}

class _JsonToDartWidgetState extends State<JsonToDartWidget> {
  var jsonStr = '';
  var code = '';
  String rootClassName = 'RootClass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildTitle(),
          _buildGenerate(),
          _buildSubmit(),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  SizedBox _buildSubmit() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'rootClass:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            width: 300,
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue, width: 1),
            ),
            child: TextField(
              maxLength: 30,
              //隐藏计算器
              buildCounter: (BuildContext context,
                  {int? currentLength, int? maxLength, bool? isFocused}) =>
              null,
              onChanged: (value) {
                rootClassName = value;
              },
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: 'rootClass',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              generateModel();
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const MouseRegion(
                cursor: SystemMouseCursors.click, // 设置鼠标悬浮时的指针样式为手指
                child: Center(
                  child: Text(
                    '生 成',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                code = '';
              });
            },
            child: Container(
              margin:  const EdgeInsets.only(left: 20),
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const MouseRegion(
                cursor: SystemMouseCursors.click, // 设置鼠标悬浮时的指针样式为手指
                child: Center(
                  child: Text(
                    '清 空',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildGenerate() {
    return SizedBox(
      height: 550,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildJSONInput(),
          _buildClassOut(),
        ],
      ),
    );
  }

  Expanded _buildClassOut() {
    return Expanded(
      child: Column(
        children: [
          const Text(
            'Class',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: HighlightView(
                          code,
                          language: 'dart',
                          padding: const EdgeInsets.all(20),
                          theme: monokaiSublimeTheme,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: copyCode,
                          child: Icon(
                            Icons.copy,
                            color: Colors.grey.shade400,
                            size: 40,
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

  Expanded _buildJSONInput() {
    return Expanded(
      child: Column(
        children: [
          const Text(
            'JSON',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                maxLength: null,
                maxLines: null,
                //隐藏计算器
                buildCounter: (BuildContext context,
                    {int? currentLength,
                      int? maxLength,
                      bool? isFocused}) =>
                null,
                onChanged: (value) {
                  jsonStr = value;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: '请输入JSON字符串',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Center(
        child: Text(
          'JSON To Dart',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void showAlert(String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭弹框
              },
              child: const Text('好的，大哥'),
            ),
          ],
        );
      },
    );
  }

  void generateModel() {
    if (jsonStr.isEmpty) {
      showAlert('别调皮', '你能不能输入了字符串在创建？');
      return;
    }
    if (isJSON(jsonStr) == false) {
      showAlert('认真点输入', '请输入有效的JSON字符串');
      return;
    }
/*
    String jsonString = '''
    {
      "name": "John Smith",
      "age": 30,
      "address": {
        "street": "123 Main St",
        "city": "New York"
      },
      "model":[{"modelID":"hello","modelData":{"dataId":"id"}}],
      "hobbies": ["reading", "traveling"]
    }
  ''';
*/
    // final classGenerator = new ModelGenerator('Sample');
    // final currentDirectory = dirname(_scriptPath());
    // final filePath = normalize(join(currentDirectory, 'sample.json'));
    // final jsonRawData = new File(filePath).readAsStringSync();
    // DartCode dartCode = classGenerator.generateDartClasses(jsonRawData);
    // print(dartCode.code);
    setState(() {
      code = ModelGenerator(rootClassName).generateDartClasses(jsonStr).code;
    });
  }

  void copyCode() {
    Future.delayed(Duration(milliseconds: 2), () {
      Clipboard.setData(ClipboardData(text: code));
      showAlert('优秀~', '复制成功');
    });
  }

  bool isJSON(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}