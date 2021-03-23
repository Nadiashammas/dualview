import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:staggered_dual_view/fruits_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Fruits',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StaggeredDualView(
            aspectRatio: 0.7,
            spacing: 30,
            itemBuilder: (context, index) {
              return FruitItem(
                fruit: fruits[index],
              );
            },
            itemCount: fruits.length,
          ),
        ),
      ),
    );
  }
}

class StaggeredDualView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  const StaggeredDualView(
      {Key key,
      this.itemBuilder,
      this.itemCount,
      this.spacing,
      this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio;
      final height = constraints.maxHeight + itemHeight;

      return OverflowBox(
        maxWidth: width,
        minWidth: width,
        maxHeight: height,
        minHeight: height,
        child: GridView.builder(
          padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(0.0, index.isOdd ? itemHeight * 0.5 : 0.0),
              child: itemBuilder(context, index),
            );
          },
          //    itemCount: fruits.length
        ),
      );
    });
  }
}

class FruitItem extends StatelessWidget {
  final Fruit fruit;

  const FruitItem({Key key, this.fruit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      shadowColor: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                fruit.image,
                fit: BoxFit.cover,
              ),
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                fruit.name,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                fruit.weight,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5,
                    (index) => Icon(
                          index < 4 ? Icons.star : Icons.star_border,
                          color: Colors.yellow[600],
                        )),
              )
            ],
          ))
        ],
      ),
    );
  }
}
