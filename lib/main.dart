import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_rank_tools/pages/homePage.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // setWindowTitle('RANK');
    // setWindowFrame(const Rect.fromLTWH(200, 100, 1280, 720));
    // setWindowMinSize(const Size(400, 400));
    // setWindowMaxSize(const Size(400, 400));

    getWindowInfo().then((windowInfo) { // OSによって配置された場所・サイズを取得し
      setWindowFrame( // 場所はそのままに、widthとheightを変更
        Rect.fromCenter(
          center: windowInfo.frame.center,
          width: 400,
          height: 400,
        )
      );
    });

    final info = await getCurrentScreen();
    print(info?.frame);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: HomePage(),
    );
  }
}
