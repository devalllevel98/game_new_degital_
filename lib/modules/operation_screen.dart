import 'dart:io';

import 'package:action_slider/action_slider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:degitalgame/gui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/styles/styles.dart';
import 'number_of_digits_screen.dart';
import '../shared/utils/keyboard_utils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({Key? key}) : super(key: key);


  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> with TickerProviderStateMixin {
  bool isCustomButtonTapped = false;
  bool isFirstLoad = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    // Automatically tap the button only once when the screen loads
    if (isFirstLoad) {
      tapButtonAutomatically();
      isFirstLoad = false;
    }

  }

  void tapButtonAutomatically() async {
    setState(() {
      isCustomButtonTapped = true;
    });

    // Wait for a short duration (e.g., 2 seconds)
    await Future.delayed(Duration(milliseconds: 50));

    setState(() {
      isCustomButtonTapped = false;
      loading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    void hideKeyboardOnHomeTap() {
      KeyboardUtils.hideKeyboard();
    }
     hideKeyboardOnHomeTap();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            // baseColor:  Colors.blue,
            image: Image(image: AssetImage('assets/logoani.png')),
          ),
        ),
        vsync: this,
        child:  Container(
      width: width,
      height: height,
      // decoration: BoxDecoration(
      //   color: Colors.black,
      //   image: DecorationImage(
      //     image: AssetImage("assets/02.jpeg"),
      //     fit: BoxFit.fitHeight,
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Spacer(),
          Center(
                child: Column(   
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        icon: Icon(
                          Icons.add_outlined,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Summation',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                            setState(() {
                              Shared.scoremultiOP=2;
                              Shared.op = '+';
                              isCustomButtonTapped = true;
                            });
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const NumberOfDigitsScreen();
                              }),
                            );
                          controller.success();
                        },
                      ),
                    SizedBox(height: 20.0),
                    ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        
                        icon: Icon(
                          Icons.remove,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Subtraction',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                        setState(() {
                              Shared.scoremultiOP=1;
                              Shared.op = '-';
                              isCustomButtonTapped = true;
                            });
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const NumberOfDigitsScreen();
                              }),
                            );
                          controller.success();
                        },
                      ),
                  SizedBox(height: 20.0),
                  ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        icon: Icon(
                          Icons.clear,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Multiplication',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                        setState(() {
                            setState(() {
                              Shared.scoremultiOP=3;
                              Shared.op = '*';
                              isCustomButtonTapped = true;
                            });
                            });
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const NumberOfDigitsScreen();
                              }),
                            );
                          controller.success();
                        },
                      ),
              SizedBox(height: 20.0),
                  ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        icon:Icon(
                              FontAwesomeIcons.divide, // Biểu tượng phép chia trong FontAwesome
                              size: height * 0.05,
                              color: Color.fromARGB(255, 148, 13, 238),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Division',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                            setState(() {
                              Shared.scoremultiOP=4;
                              Shared.op = '/';
                              isCustomButtonTapped = true;
                            });
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const NumberOfDigitsScreen();
                              }),
                            );
                          controller.success();
                        },
                      ),
SizedBox(height: 20.0),
                  ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        icon:Icon(
                          Icons.help,
                          color:  Color.fromARGB(255, 248, 223, 2),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Guideline',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Guiline()),
                            );
                          controller.success();
                        },
                      ),
SizedBox(height: 20.0),
                  ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
                        toggleColor: Color(0xffffffff),
                        icon:Icon(
                          Icons.exit_to_app,
                          color:  Color.fromARGB(255, 238, 4, 16),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Quit App',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontFamily: "impact")),
                          ],
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 2));
                          exit(0);
                          // controller.success();
                        },
                      ),
                  ],
                  
                ),

              ),

        ],
      ),
    )
     
      ),
      // backgroundColor: Styles.main,
      // appBar:buildAppBar(context),

      // body: ConditionalBuilder(
      //   condition: loading,
      //   builder: (context)=> Center(
      //     child: SingleChildScrollView(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const SizedBox(height: 25,),
      //           CustomButton(
      //             buttonText: 'ADD',
      //             icon: Icons.add,
      //             onTap: () {
      //               setState(() {
      //                 Shared.scoremultiOP=2;
      //                 Shared.op = '+';
      //                 isCustomButtonTapped = true;
      //               });
      //             },
      //             color: isCustomButtonTapped && Shared.op == '+' ? Styles.blueColor : null,
      //             textColor: isCustomButtonTapped && Shared.op == '+' ? Styles.darkColor : null,
      //           ),
      //           const SizedBox(height: 15,),
      //           CustomButton(
      //             buttonText: 'SUBTRACT',
      //             icon: Icons.remove,
      //             onTap: () {
      //               setState(() {
      //                 Shared.scoremultiOP=1;

      //                 Shared.op = '-';
      //                 isCustomButtonTapped = true;
      //               });
      //             },
      //             color: isCustomButtonTapped && Shared.op == '-' ? Styles.blueColor : null,
      //             textColor: isCustomButtonTapped && Shared.op == '-' ? Styles.darkColor : null,

      //           ),
      //           const SizedBox(height: 15,),
      //           CustomButton(
      //             buttonText: 'MULTIPLY',
      //             icon: Icons.close,
      //             onTap: () {
      //               setState(() {
      //                 Shared.scoremultiOP=3;
      //                 Shared.op = '*';
      //                 isCustomButtonTapped = true;
      //               });
      //             },
      //             color: isCustomButtonTapped && Shared.op == '*' ? Styles.blueColor : null,
      //             textColor: isCustomButtonTapped && Shared.op == '*' ? Styles.darkColor : null,

      //           ),
      //           const SizedBox(height: 15,),
      //           CustomButton(
      //             buttonText: 'DIVIDE',
      //             icon: CupertinoIcons.divide,
      //             onTap: () {
      //               setState(() {
      //                 Shared.scoremultiOP=4;
      //                 Shared.op = '/';
      //                 isCustomButtonTapped = true;
      //               });
      //             },
      //             color: isCustomButtonTapped && Shared.op == '/' ? Styles.blueColor : null,
      //             textColor: isCustomButtonTapped && Shared.op == '/' ? Styles.darkColor : null,

      //           ),
      //           const SizedBox(height: 30,),
      //           if (!isCustomButtonTapped)
      //             const SizedBox(height: 66,),

      //           if (isCustomButtonTapped && loading && !isFirstLoad)
      //             SmallCustomButton(
      //               buttonText: 'NEXT',
      //               onTap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (BuildContext context) {
      //                     return const NumberOfDigitsScreen();
      //                   }),
      //                 );
      //               },
      //             ),
      //           const SizedBox(height: 30,),
      //         ],
      //       ),
      //     ),
      //   ),
      //   fallback: (context)=> Center(child: CircularProgressIndicator(color: Styles.pinkColor,)),
      // ),
    
    );
  }
}