import 'package:flutter/material.dart';
import 'package:newsly/model/category_model.dart';
import 'package:newsly/services/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CategoryModel> categories = [];
@override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"), 
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
              ),
            ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length, 
              itemBuilder: (context,index){
                return CategoryTitle(
                  image: categories[index].image, 
                  categoryName: categories[index].categoryName,
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final image, categoryName;
  CategoryTitle({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:  Image.asset(
              image,
              width: 120,
              height: 70, fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}