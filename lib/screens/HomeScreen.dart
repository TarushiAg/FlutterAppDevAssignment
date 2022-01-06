import 'package:app_developer_assignment/blocs/HomeBloc.dart';
import 'package:app_developer_assignment/models/RecommendationResponseModel.dart';
import 'package:app_developer_assignment/models/UserDetailResponseModel.dart';
import 'package:app_developer_assignment/util/Response.dart';
import 'package:app_developer_assignment/util/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_developer_assignment/util/ErrorWidget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_indicator/loading_indicator.dart';


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
  bool fetchDataComplete = false;

  @override
  void initState() {
    homeBloc = HomeBloc();
    fetchData();
    super.initState();
  }

  fetchData() async {
    isLoading = true;
    await homeBloc.getUserDetails();
    await homeBloc.fetchRecommendation(currentCursor);
    fetchDataComplete = true;
    setState(() {
      isLoading = false;
    });
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
              child: Text(
            "Flyingwolf",
            style: TextStyle(color: Colors.black),
          )),
        ),
        body: !fetchDataComplete
            ? Center(
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  color: kPrimaryColor,
                  colors: const [Colors.white],
                ),
              )
            : LazyLoadScrollView(
                isLoading: isLoading,
                onEndOfPage: () => _loadMore(),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //User details section
                        StreamBuilder<Response<dynamic>>(
                          stream: homeBloc.userStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data.status) {
                                case Status.LOADING:
                                  break;
                                case Status.COMPLETED:
                                  UserDetailResponseModel user =
                                      UserDetailResponseModel.fromJson(
                                          snapshot.data.data);
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: user.imageUrl,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    new CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage:
                                                            imageProvider,
                                                        backgroundColor:
                                                            Colors.transparent),
                                            errorWidget: (context, url,
                                                    error) =>
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey.shade300,
                                                    radius: 50,
                                                    child: new Text(
                                                      "TA",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.name,
                                                textScaleFactor: 1.5,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueAccent,
                                                        width: 1.5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(user.rating.toString(),
                                                        textScaleFactor: 1.8,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text("Elo rating",
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            color: kGreyColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1)),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    user.tournamentPlayed
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textScaleFactor: 1.3,
                                                  ),
                                                  Text(
                                                    "Tournaments",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textScaleFactor: 1,
                                                  ),
                                                  Text(
                                                    "played",
                                                    style: TextStyle(
                                                        color: Colors.white),
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
                                                      color: Colors.white,
                                                      width: 1)),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    user.tournamentWon
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textScaleFactor: 1.3,
                                                  ),
                                                  Text(
                                                    "Tournaments",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textScaleFactor: 1,
                                                  ),
                                                  Text(
                                                    "won",
                                                    style: TextStyle(
                                                        color: Colors.white),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25)),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1)),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${user.winPercentage}%",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textScaleFactor: 1,
                                                  )
                                                ],
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                  break;
                                case Status.ERROR:
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Error(
                                      textColor: Colors.grey,
                                      errorMessage: "Something went wrong!",
                                      onRetryPressed: () {
                                        homeBloc.clearUserStream();
                                        homeBloc.getUserDetails();
                                      },
                                    ),
                                  );
                                  break;
                              }
                            }
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: LoadingIndicator(
                                        indicatorType: Indicator.ballPulse,
                                        color: kPrimaryColor,
                                        colors: const [Colors.white],
                                      )),
                                ),
                              ],
                            );
                          },
                        ),

                        //Recommendation List
                        StreamBuilder<Response<dynamic>>(
                          stream: homeBloc.recommedationStream,
                          builder: (context, snapshot) {
                            bool isError = false;
                            // print(snapshot.connectionState);
                            if (snapshot.hasData && !isError) {
                              switch (snapshot.data.status) {
                                case Status.LOADING:
                                  break;
                                case Status.COMPLETED:
                                  isError = false;
                                  RecommendationResponseModel recommendation =
                                      RecommendationResponseModel.fromJson(
                                          snapshot.data.data);
                                  currentCursor = recommendation.data.cursor;
                                  if (recommendation != null) {
                                    for (int i = 0;
                                        i <
                                            recommendation
                                                .data.tournaments.length;
                                        i++) {
                                      tournaments.add(
                                          recommendation.data.tournaments[i]);
                                    }
                                    print(tournaments.length);
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //Recommedation title
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text(
                                          "Recommended for you",
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListView.builder(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.0,
                                                                  1.0), //(x,y)
                                                              blurRadius: 6.0,
                                                            ),
                                                          ],
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  tournaments[
                                                                          index]
                                                                      .coverUrl)),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25.0)),
                                                          color: Colors
                                                              .grey.shade300,
                                                        ),
                                                        height: MediaQuery.of(
                                                                    context)
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Spacer(),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.11,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        25.0)),
                                                            color:
                                                                Colors.white),
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
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              10,
                                                                              10,
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        tournaments[index]
                                                                            .name,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        textScaleFactor:
                                                                            1.2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              20),
                                                                          child:
                                                                              Text(
                                                                            tournaments[index].gameName,
                                                                            style:
                                                                                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500),
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
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios_rounded,
                                                                color:
                                                                    Colors.grey,
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
                                      ),
                                    ],
                                  );
                                  break;
                                case Status.ERROR:
                                  isError = true;
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 20, left: 8),
                                          child: Text(
                                            "Recommended for you",
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Error(
                                            textColor: Colors.grey,
                                            errorMessage:
                                                "Something went wrong!",
                                            onRetryPressed: () {
                                              homeBloc
                                                  .clearRecommendationStream();
                                              homeBloc.fetchRecommendation(
                                                  currentCursor);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  break;
                              }
                            }
                            return LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              color: kPrimaryColor,
                              colors: const [Colors.white],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
