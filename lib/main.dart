import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomeModel {
  final String id;
  final String author;

  MyHomeModel({
    required this.id,
    required this.author,
  });
  MyHomeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        author = json["author"];
}

class MyHomeViewModel extends GetxController {
  var counter = 0.obs;
  //RxInt counter = 0.obs;

  final GetConnect _getConnect = GetConnect();

  Future<List<MyHomeModel>> _fetch({required int pageNo}) async {
    try {
      final _response = await _getConnect.get("");
      if (_response.statusCode == 200) {
        List<dynamic> _data = _response.body as List<dynamic>;
        List<MyHomeModel> _result =
            _data.map((e) => MyHomeModel.fromJson(e)).toList();
        return _result;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  void incrementCounter() {
    counter++;
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late final MyHomeViewModel _obj;

  @override
  Widget build(BuildContext context) {
    _obj = Get.put(MyHomeViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("수학비서"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() => Text(
                  '${_obj.counter.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _obj.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
