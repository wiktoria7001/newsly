import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsly/model/category_model.dart';
import 'package:newsly/model/slider_mode.dart';
import 'package:newsly/services/data.dart';
import 'package:newsly/services/slider_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CategoryModel> categories = [];
List<SliderModel> sliders = [];
int activeIndex = 0;

@override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
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
            ),
            SizedBox(height: 30.0,),
            CarouselSlider.builder(itemCount: sliders.length, itemBuilder: (context, index, realIndex){
              String? res = sliders[index].image;
              String? name = sliders[index].name;
              return buildImage(res!, index, name!);
            }, options: CarouselOptions(
                height: 250, 
                autoPlay: true,
                enlargeCenterPage: true, 
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index,reason) {
                  setState(() {
                    activeIndex = index;
                  });
                })
                ) ,
          ],
        ),
      ),
    );
  }
    Widget buildImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
         ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image, 
            height: 250,
            fit: BoxFit.cover, 
            width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10.0),
            margin: EdgeInsets.only(top: 170.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                )
              ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
                )
              ),
          ),
        ]
      ),
    ) ;
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