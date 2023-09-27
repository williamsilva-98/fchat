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
