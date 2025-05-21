import 'package:flutter/material.dart';


class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ListView with Centered Container'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 20, // リストアイテムの数
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false, // スクロールコンテンツではないことを示す
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Center',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}