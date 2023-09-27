<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This package abstracts all the complexity in creating the UI, UX and functionalities when creating a Chat in Flutter. Just plug and play.

## Features
For now, in this first version it is possible to send only text messages

## Getting started
First you nedd to add this package to your pubspec.yaml file

```dart
dependencies:
  flutter:
    sdk: flutter
  fchat: ˆ1.0.0
```

or just run in your terminal

```dart
flutter pub add fchat
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:fchat/fchat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<MessageModel> messages = [];
  final user = UserModel(
    id: 1,
    name: 'William',
    photoUrl: 'https://i.pravatar.cc/150?img=8',
  );

  final user2 = UserModel(
    id: 2,
    name: 'Cíntia',
    photoUrl: 'https://i.pravatar.cc/150?img=5',
  );

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<List<MessageModel>> getMessages() async {
    await Future.delayed(const Duration(seconds: 4));
    return [
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch,
        author: user,
        message: 'Olá, tudo bem?',
        date: DateTime.now(),
      ),
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch,
        author: user2,
        message: 'Como vai você?',
        date: DateTime.now(),
      ),
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch,
        author: user2,
        message: 'Tudo bem?',
        date: DateTime.now(),
      ),
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch,
        author: user2,
        message: 'Tudo sim e você?',
        date: DateTime.now(),
      ),
    ];
  }

  void onSend(String value) {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch,
      author: user2,
      message: value,
      date: DateTime.now(),
    );

    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getMessages(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                return FChat(
                  messages: snapshot.data as List<MessageModel>,
                  onSend: onSend,
                  user: user,
                );
              }
              break;
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
          }
          
          return FChat(
            messages: messages,
            onSend: onSend,
            user: user,
          );
        },
      ),
    );
  }
}

```

## Additional information
Feel free to contribute to this project. All pull requests will be analyzed.
