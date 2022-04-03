import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_103_bug/bloc.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page1(),
      routes: {
        "/page1": (_) => const Page1(),
        "/page2": (_) => const Page2(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/page2');
        },
        child: const Text('Go to page 2'),
      ),
    ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer(
          builder: ((_, ref, __) {
            return ref.watch(someFutureProvider).when(
                  data: (data) => Text('Data: $data'),
                  error: (error, _) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                );
          }),
        ),
      ),
    );
  }
}
