import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsletter/auth/auth_page.dart';
import 'package:newsletter/intoduction_screens/intro_page1.dart';
import 'package:newsletter/intoduction_screens/intro_page2.dart';
import 'package:newsletter/intoduction_screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainIntro extends StatefulWidget {
  const MainIntro({super.key});

  @override
  State<MainIntro> createState() => _MainIntroState();
}

class _MainIntroState extends State<MainIntro> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip button
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('skip')),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                      dotColor: Colors.grey, activeDotColor: Color(0xFFf58634)),
                ),

                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AuthPage();
                          }));
                        },
                        child: Text('done'))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('next'))

                //next or done
              ],
            )),
      ],
    ));
  }
}
