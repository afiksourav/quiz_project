import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/bloc/topicOfQuestions/topic_of_questions_bloc.dart';
import 'package:quiz/pages/quize_page/Indroduction_start_now.dart';
import 'package:quiz/services/repo/repositores.dart';
import 'package:shimmer/shimmer.dart';

class IntroductionPage extends StatefulWidget {
  final String slug;
  const IntroductionPage({super.key, required this.slug});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  List<dynamic> posts = [];
  int currentPage = 1;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                setState(() {});
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  @override
  void initState() {
    super.initState();
    _fetchPosts();

    print("rrrrrrrrrrrrrrrrrr${widget.slug}");

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });
  }

  Future<void> _fetchPosts() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    Map allQuestions = await Repositores().topicsOfQuestions(widget.slug, currentPage);
    List allQuestionsData = allQuestions['data']['questions']['data'];

    setState(() {
      posts.addAll(allQuestionsData);
      print("topicsOfQuestions");
      print(posts);
      currentPage++;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(150),
      //   child: AppBar(
      //     flexibleSpace: Container(
      //       height: 200,
      //       decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //         colors: [
      //           Color(0xFF220F4D),
      //           Color(0xFF37165C),
      //         ],
      //       )),
      //     ),
      //     centerTitle: true,
      //     leading: Column(
      //       children: [
      //         SizedBox(
      //           height: 15.h,
      //         ),
      //         Container(
      //             height: 37.h,
      //             width: 37.w,
      //             decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey.withOpacity(0.2),
      //                   spreadRadius: 2,
      //                   blurRadius: 4,
      //                   offset: Offset(0, 1), // changes position of shadow
      //                 ),
      //               ],
      //               color: Color(0xFFFFFFFF),
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(12.r),
      //                 topRight: Radius.circular(12.r),
      //                 bottomLeft: Radius.circular(12.r),
      //                 bottomRight: Radius.circular(12.r),
      //               ),
      //             ),
      //             child: IconButton(
      //                 color: Colors.black,
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                   // Navigator.of(context).pushReplacement(
      //                   //   MaterialPageRoute(
      //                   //     builder: (BuildContext context) => HomePage(),
      //                   //   ),
      //                   // );
      //                 },
      //                 icon: Icon(Icons.arrow_back))),
      //       ],
      //     ),
      //     title: Text(
      //       'Introduction',
      //     ),
      //     // actions: [
      //     //   IconButton(
      //     //       onPressed: () {},
      //     //       icon: const Icon(
      //     //         Icons.person,
      //     //         color: Colors.white,
      //     //       ))
      //     // ],
      //   ),
      // ),

      body: Column(
        children: [
          Container(
            height: 122.h,
            width: 375.w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF220F4D), Color(0xFF37165C)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.4, 0.7],
                tileMode: TileMode.repeated,
              ),
              //color: Color(0xFF220F4D),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    children: [
                      Container(
                        height: 37.h,
                        width: 37.w,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14.r),
                            topRight: Radius.circular(14.r),
                            bottomLeft: Radius.circular(14.r),
                            bottomRight: Radius.circular(14.r),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              "assets/icon/arro.svg",
                              width: 14.w,
                              height: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 85.w,
                      ),
                      Text(
                        "Introduction",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: SizedBox(
              height: 83.h,
              child: GestureDetector(
                onTap: () async {
                  // await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  //   return IntroductionStartNowPage(
                  //     slug: widget.slug,
                  //   );
                  // }));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/qqq.png",
                          fit: BoxFit.cover,
                        ),
                        // SizedBox(
                        //   width: 20.w,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Want to challenge your\nknowledge?",
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Color(0xFF1D2746)),
                            ),
                            Text(
                              "Try our quizzes.",
                              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xFF6A737C)),
                            )
                          ],
                        ),
                        // SizedBox(
                        //   width: 20.w,
                        // ),
                        SizedBox(
                          height: 35.h,
                          width: 83.w,
                          child: TextButton(
                              onPressed: () async {
                                final connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.mobile ||
                                    connectivityResult == ConnectivityResult.wifi ||
                                    connectivityResult == ConnectivityResult.ethernet) {
                                  print("slg1111111111${widget.slug}");
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return IntroductionStartNowPage(
                                      slug: widget.slug,
                                    );
                                  }));
                                } else {
                                  print("internet off");
                                  showDialogBox();
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF078669), // Background Color
                              ),
                              child: Text(
                                "Try Quizzes",
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Expanded(
            child: Container(
              // color: Colors.amber,
              child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index < posts.length) {
                    final post = posts[index];
                    return posts[index]['options'].length == 0
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                // height: 250.h,
                                width: 325.w,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 1), //  // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(
                                      5,
                                    ))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(posts[index]['title'],
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF1D2746),
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    "A . ${(posts[index]['options'] as List).length < 1 ? " " : posts[index]['options'][0]['title'].toString()}",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: (posts[index]['options'] as List).length < 1
                                                          ? Color(0xFF6A737C)
                                                          : posts[index]['options'][0]['correct_ans'] == 1
                                                              ? Color(0xFF078669)
                                                              : Color(0xFF6A737C),
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "B. ${(posts[index]['options'] as List).length < 2 ? " " : posts[index]['options'][1]['title'].toString()}",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: posts[index]['options'].length < 2
                                                          ? Color(0xFF6A737C)
                                                          : posts[index]['options'][1]['correct_ans'] == 1
                                                              ? Color(0xFF078669)
                                                              : Color(0xFF6A737C),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    "C. ${(posts[index]['options'] as List).length < 3 ? " " : posts[index]['options'][2]['title'].toString()}",
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: posts[index]['options'].length < 3
                                                          ? Color(0xFF6A737C)
                                                          : posts[index]['options'][2]['correct_ans'] == 1
                                                              ? Color(0xFF078669)
                                                              : Color(0xFF6A737C),
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "D. ${(posts[index]['options'] as List).length < 4 ? ' ' : posts[index]['options'][3]['title'].toString()} ",
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: (posts[index]['options'] as List).length < 4
                                                          ? Color(0xFF6A737C)
                                                          : posts[index]['options'][3]['correct_ans'] == 1
                                                              ? Color(0xFF078669)
                                                              : Color(0xFF6A737C),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Difficulty",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Color(0xFF6A737C),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Container(
                                                height: 5.h,
                                                width: 5.w,
                                                decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Image.asset(
                                                "assets/icon/v.png",
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                posts[index]['difficulty_point'].toString(),
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Color(0xFF6A737C),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Container(
                                                height: 5.h,
                                                width: 5.w,
                                                decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Container(
                                                  height: 15.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(5)),
                                                  child: Center(
                                                    child: Text(
                                                      posts[index]['difficulty_level'],
                                                      style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: Colors.white),
                                                    ),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                  } else if (isLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[700]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 30.0.r,
                        ),
                        title: Text('Loading...', style: TextStyle(fontSize: 14.0.sp)),
                        subtitle: Text('Question', style: TextStyle(fontSize: 12.0.sp)),
                      ),
                    );
                  } else {
                    //return SizedBox(height: 20, child: Center(child: Text("no data")));
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ),

          // BlocBuilder<TopicOfQuestionsBloc, TopicOfQuestionsState>(
          //   builder: (context, state) {
          //     if (state is TopicOfQuestionsInitial) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     if (state is TopicOfQuestionsGetState) {
          //       print("quessssssssssss   afikkkkkkkkk");
          //       // print(state.allQuestionsData);
          //       return Container(
          //         height: 500,
          //         child: ListView.builder(
          //           itemCount: state.allQuestionsData.length,
          //           itemBuilder: (context, index) {
          //             // log('${state.allQuestionsData[index]['title']}');

          //             // log('${state.allQuestionsData[index]['options'][0]['correct_ans']}');
          //             //log("${state.allQuestionsData[index]['options'] != []}");
          //             return state.allQuestionsData[index]['options'].length == 0
          //                 ? Container()
          //                 : Column(
          //                     children: [
          //                       SizedBox(
          //                         height: 20.h,
          //                       ),
          //                       Padding(
          //                         padding: EdgeInsets.only(
          //                           left: 15.w,
          //                           right: 15.w,
          //                         ),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           children: [
          //                             Text(state.allQuestionsData[index]['title'],
          //                                 style: TextStyle(
          //                                   fontSize: 15.sp,
          //                                   fontWeight: FontWeight.w500,
          //                                   color: Color(0xFF1D2746),
          //                                 )),
          //                             SizedBox(
          //                               height: 5.h,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Expanded(
          //                                   child: Text("A . ${state.allQuestionsData[index]['options'][0]['title'].toString()}",
          //                                       style: TextStyle(
          //                                         fontSize: 12.sp,
          //                                         fontWeight: FontWeight.w400,
          //                                         color:
          //                                             state.allQuestionsData[index]['options'][0]['correct_ans'] == 0 ? Color(0xFF078669) : Color(0xFF6A737C),
          //                                       )),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Expanded(
          //                                   child: Text("B. ${state.allQuestionsData[index]['options'][1]['title'].toString()}",
          //                                       style: TextStyle(
          //                                         fontSize: 12.sp,
          //                                         fontWeight: FontWeight.w400,
          //                                         color:
          //                                             state.allQuestionsData[index]['options'][1]['correct_ans'] == 0 ? Color(0xFF078669) : Color(0xFF6A737C),
          //                                       )),
          //                                 ),
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               height: 5.h,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Expanded(
          //                                   child: Text("C. ${state.allQuestionsData[index]['options'][2]['title'].toString()}",
          //                                       style: TextStyle(
          //                                         fontSize: 13.sp,
          //                                         fontWeight: FontWeight.w400,
          //                                         color:
          //                                             state.allQuestionsData[index]['options'][2]['correct_ans'] == 0 ? Color(0xFF078669) : Color(0xFF6A737C),
          //                                       )),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Expanded(
          //                                   child: Text("D. ${state.allQuestionsData[index]['options'][3]['title'].toString()}",
          //                                       style: TextStyle(
          //                                         fontSize: 13.sp,
          //                                         fontWeight: FontWeight.w400,
          //                                         color:
          //                                             state.allQuestionsData[index]['options'][3]['correct_ans'] == 0 ? Color(0xFF078669) : Color(0xFF6A737C),
          //                                       )),
          //                                 ),
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               height: 10.h,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Text(
          //                                   "Difficulty",
          //                                   style: TextStyle(
          //                                     fontSize: 10.sp,
          //                                     color: Color(0xFF6A737C),
          //                                     fontWeight: FontWeight.w400,
          //                                   ),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Container(
          //                                   height: 5.h,
          //                                   width: 5.w,
          //                                   decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Image.asset(
          //                                   "assets/icon/v.png",
          //                                   fit: BoxFit.cover,
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Text(
          //                                   "300",
          //                                   style: TextStyle(
          //                                     fontSize: 10.sp,
          //                                     color: Color(0xFF6A737C),
          //                                     fontWeight: FontWeight.w400,
          //                                   ),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Container(
          //                                   height: 5.h,
          //                                   width: 5.w,
          //                                   decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5.w,
          //                                 ),
          //                                 Container(
          //                                     height: 15.h,
          //                                     width: 40.w,
          //                                     decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(5)),
          //                                     child: Center(
          //                                       child: Text(
          //                                         "Very Low",
          //                                         style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: Colors.white),
          //                                       ),
          //                                     )),
          //                               ],
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   );
          //           },
          //         ),
          //       );
          //     }
          //     return Container();
          //   },
          // ),

          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 27.w,
          //   ),
          //   child: SizedBox(
          //     height: 90.h,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text("1. The term PHP is an acronym for PHP______.",
          //             style: TextStyle(
          //               fontSize: 15.sp,
          //               fontWeight: FontWeight.w500,
          //               color: Color(0xFF1D2746),
          //             )),
          //         SizedBox(
          //           height: 5.h,
          //         ),
          //         Row(
          //           children: [
          //             Text("A. Hypertext Preprocessor",
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xFF078669),
          //                 )),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Text("B. Hypertext Preprocessor",
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xFF6A737C),
          //                 )),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 5.h,
          //         ),
          //         Row(
          //           children: [
          //             Text("C. Hypertext Preprocessor",
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xFF6A737C),
          //                 )),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Text("D. Hypertext Preprocessor",
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xFF6A737C),
          //                 )),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10.h,
          //         ),
          //         Row(
          //           children: [
          //             Text(
          //               "Difficulty",
          //               style: TextStyle(
          //                 fontSize: 10.sp,
          //                 color: Color(0xFF6A737C),
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Container(
          //               height: 5.h,
          //               width: 5.w,
          //               decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
          //             ),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Image.asset(
          //               "assets/icon/v.png",
          //               fit: BoxFit.cover,
          //             ),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Text(
          //               "300",
          //               style: TextStyle(
          //                 fontSize: 10.sp,
          //                 color: Color(0xFF6A737C),
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Container(
          //               height: 5.h,
          //               width: 5.w,
          //               decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(10)),
          //             ),
          //             SizedBox(
          //               width: 5.w,
          //             ),
          //             Container(
          //                 height: 15.h,
          //                 width: 40.w,
          //                 decoration: BoxDecoration(color: Color(0xFF078669), borderRadius: BorderRadius.circular(5)),
          //                 child: Center(
          //                   child: Text(
          //                     "Very Low",
          //                     style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: Colors.white),
          //                   ),
          //                 )),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
