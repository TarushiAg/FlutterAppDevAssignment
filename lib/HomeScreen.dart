import 'package:app_developer_assignment/HomeBloc.dart';
import 'package:app_developer_assignment/RecommendationResponseModel.dart';
import 'package:app_developer_assignment/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_developer_assignment/ErrorWidget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'Response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc;
  List<Tournaments> tournaments = [];
  bool isLoading = false;
  String currentCursor = "";

  @override
  void initState() {
    homeBloc = HomeBloc();
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    isLoading = true;
    print("loading");
    await homeBloc.fetchRecommendation(currentCursor);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LazyLoadScrollView(
      isLoading: isLoading,
      onEndOfPage: () => _loadMore(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: "www.sample.com",
                            imageBuilder: (context, imageProvider) =>
                                new CircleAvatar(
                                    radius: 50,
                                    backgroundImage: imageProvider,
                                    backgroundColor: Colors.transparent),
                            errorWidget: (context, url, error) => CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius: 50,
                                child: new Text(
                                  "TA",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Simon Baker",
                                textScaleFactor: 1.5,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.blueAccent, width: 1.5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("2250",
                                        textScaleFactor: 1.8,
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold)),
                                    Text("Elo rating",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            color: kGreyColor,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffe58200),
                                      Color(0xffeba102),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "07",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.3,
                                  ),
                                  Text(
                                    "Tournaments",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    "played",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1,
                                  )
                                ],
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xff4f299b),
                                      Color(0xff9d51bb),
                                    ],
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "07",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.3,
                                  ),
                                  Text(
                                    "Tournaments",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    "won",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1,
                                  )
                                ],
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xffec5645),
                                      Color(0xffef7a4e),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "07",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.3,
                                  ),
                                  Text(
                                    "Winning",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    "percentage",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1,
                                  )
                                ],
                              )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  //Recommedation title
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Recommended for you",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  //Recommendation List
                  StreamBuilder<Response<dynamic>>(
                    stream: homeBloc.recommedationStream,
                    builder: (context, snapshot) {
                      // print(snapshot.connectionState);
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            break;
                          case Status.COMPLETED:
                            RecommendationResponseModel recommendation =
                                RecommendationResponseModel.fromJson(
                                    snapshot.data.data);
                            currentCursor = recommendation.data.cursor;
                            if (recommendation != null) {
                              for (int i = 0;
                                  i < recommendation.data.tournaments.length;
                                  i++) {
                                tournaments
                                    .add(recommendation.data.tournaments[i]);
                              }
                              print(tournaments.length);
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: tournaments.length,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                        0.0, 1.0), //(x,y)
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        tournaments[index]
                                                            .coverUrl)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)),
                                                color: Colors.grey.shade300,
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.27,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Spacer(),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25.0)),
                                                  color: Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(10,
                                                                    10, 10, 5),
                                                            child: Text(
                                                              tournaments[index]
                                                                  .name,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textScaleFactor:
                                                                  1.2,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        20),
                                                                child: Text(
                                                                  tournaments[
                                                                          index]
                                                                      .gameName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  textScaleFactor:
                                                                      1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                            break;
                          case Status.ERROR:
                            return Error(
                              textColor: Colors.grey,
                              errorMessage: "Something went wrong!",
                              onRetryPressed: () {
                                homeBloc.fetchRecommendation(currentCursor);
                              },
                            );
                            break;
                        }
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
