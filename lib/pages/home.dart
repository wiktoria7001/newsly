import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsly/model/article_model.dart';
import 'package:newsly/model/category_model.dart';
import 'package:newsly/model/slider_mode.dart';
import 'package:newsly/pages/all_news.dart';
import 'package:newsly/pages/article_view.dart';
import 'package:newsly/pages/category_news.dart';
import 'package:newsly/services/data.dart';
import 'package:newsly/services/slider_data.dart';
import 'package:newsly/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CategoryModel> categories = [];
List<SliderModel> sliders = [];
List<ArticleModel> articles = []; 
bool _loading = true;
int activeIndex = 0;

@override
  void initState() {
    categories = getCategories();
    getNews();
    getSliders();
    super.initState();
  }

  getNews()async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

    getSliders()async{
      Sliders slider = Sliders();
      await slider.getSliders();
      sliders = slider.sliders;
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
        automaticallyImplyLeading: false,
      ),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length, 
                itemBuilder: (context,index){
                  return CategoryTile(
                    image: categories[index].image, 
                    categoryName: categories[index].categoryName,
                    );
                }),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breaking News!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        ),
                      ),
                       GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AllNews(news: "Breaking")));
                        },
                         child: Text(
                          "View All",
                          style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          ),
                                               ),
                       ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              CarouselSlider.builder(
                itemCount: 5, 
                itemBuilder: (context, index, realIndex){
                String? res = sliders[index].urlToImage;
                String? res1 = sliders[index].title;
                return buildImage(res!, index, res1!);
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
                  SizedBox(height: 30.0),
                  Center(child: buildIndicator()),
                  SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending News!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        ),
                      ),
                        GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AllNews(news: "Trending")));
                        },
                         child: Text(
                          "View All",
                          style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          ),
                         ),
                       )
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length, 
                  itemBuilder: (context, index) {
                  return BlogTile(
                    imageUrl: articles[index].urlToImage!, 
                    title: articles[index].title!, 
                    desc: articles[index].description!,
                    url: articles[index].url!);
                }),
              )
            ],
          ),
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
          child: CachedNetworkImage(
            imageUrl: image, 
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
              maxLines: 2,
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
    Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex, 
      count: 5,
      effect: SlideEffect(
        dotWidth: 15,
        dotHeight: 15,
        activeDotColor: Colors.blue,
      ),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
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
      ),
    );
  }
}

class BlogTile  extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl,required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
  return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0 ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 120, 
                      width: 120,
                      fit: BoxFit.cover, 
                      imageUrl: imageUrl,
                      ),
                  )
                ), 
                SizedBox(width: 8.0,),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            ),
                          ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            ),
                          ),
                    ),
              
                  ],
                ),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}