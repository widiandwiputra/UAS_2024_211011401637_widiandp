import 'package:flutter/material.dart';
import 'models/crypto.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS Crypto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoListPage(),
    );
  }
}

class CryptoListPage extends StatefulWidget {
  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late Future<List<Crypto>> futureCryptos;

  @override
  void initState() {
    super.initState();
    futureCryptos = ApiService.fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UAS Crypto'),
      ),
      body: Center(
        child: FutureBuilder<List<Crypto>>(
          future: futureCryptos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final crypto = snapshot.data![index];
                  return ListTile(
                    title: Text('${crypto.name} (${crypto.symbol})'),
                    subtitle: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
