import 'package:flutter/material.dart';
import 'package:flutter_app/helper/news.dart';
import 'package:flutter_app/models/article_model.dart';

import 'home.dart';

class CategoryNewsState extends StatefulWidget {
  final String category;

  CategoryNewsState({this.category});

  @override
  _CategoryNewsStateState createState() => _CategoryNewsStateState();
}

class _CategoryNewsStateState extends State<CategoryNewsState> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Ne",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 32,
              ),
            ),
            Text(
              "ws",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Roboto',
                fontSize: 32,
              ),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url);
                  }),
            )
          ],
        )
        ),
      ),
    );
  }
}

