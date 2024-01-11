import 'package:action_slider/action_slider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:degitalgame/gui.dart';
import 'package:degitalgame/modules/operation_screen.dart';
import 'package:flutter/material.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/styles/styles.dart';
import '../modules/quiz_screen.dart';

enum Difficulty { easy, med, hard }

class NumberOfDigitsScreen extends StatefulWidget {
  const NumberOfDigitsScreen({Key? key}) : super(key: key);

  @override
  State<NumberOfDigitsScreen> createState() => _NumberOfDigitsScreenState();
}

class _NumberOfDigitsScreenState extends State<NumberOfDigitsScreen> with TickerProviderStateMixin {
  Color customButtonColor = Styles.blueColor;
  bool isCustomButtonTapped = false;
  Difficulty _selectedDifficulty = Difficulty.easy;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: buildAppBar(context),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            image: Image(image: AssetImage('assets/logoani.png')),
          ),
        ),
        vsync: this,
        child:       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Choose difficulty !", style: TextStyle(color: Color.fromARGB(255, 229, 241, 8), fontSize: 20, fontFamily: "impact"),),
              SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10.0,
                trackShape: const RoundedRectSliderTrackShape(),
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 14.0,
                  pressedElevation: 8.0,
                ),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.pinkAccent,
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.black,
                valueIndicatorTextStyle: const TextStyle(
                  color: Styles.darkColor,
                  fontSize: 20.0,
                ),
              ),
              child: Slider(
                value: _selectedDifficulty.index.toDouble(),
                min: 0,
                max: 2,
                divisions: 2,
                activeColor: Color.fromARGB(255, 229, 241, 8),
                inactiveColor: Styles.darkColor,
                onChanged: (double value) {
                  setState(() {
                    _selectedDifficulty = Difficulty.values[value.toInt()];
                  });
                },
                label: _selectedDifficulty.toString().split('.').last,
              ),
            ),
              ],
            ),

          ),

  /// button 1
  ///   
        _selectedDifficulty == Difficulty.easy ? 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(
                  Icons.star_rate_rounded,
                  color:Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
          ],
        ): 
       _selectedDifficulty == Difficulty.med ? 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(
                  Icons.star_rate_rounded,
                  color: Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
                          Icon(
                  Icons.star_rate_rounded,
                  color: Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
          ],
        ): Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(
                  Icons.star_rate_rounded,
                  color:Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
              Icon(
                  Icons.star_rate_rounded,
                  color: Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
                        Icon(
                  Icons.star_rate_rounded,
                  color: Color.fromARGB(255, 176, 252, 0),
                  size: 32,
                ),
          ],
        ),
        SizedBox(height: 10.0),
        ActionSlider.standard(
            width: width * 0.6,
            backgroundColor: Colors.transparent,
            toggleColor: Color(0xffffffff),
            icon: Icon(
              Icons.play_arrow,
              color:  Color.fromARGB(255, 176, 252, 0),
              size: height * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width*0.08),

                Text(
                  _selectedDifficulty == Difficulty.easy  ? '? ${Shared.op} ?':
                  _selectedDifficulty == Difficulty.med ? '??? ${Shared.op} ???':
                  '????? ${Shared.op} ?????'


                    ,
                    style: TextStyle(
                        color: Color.fromARGB(255, 176, 252, 0),
                        fontSize: height*0.022,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            action: (controller) async {
              if(_selectedDifficulty == Difficulty.hard){
                  setState(() {
                    Shared.scoremultiDI = 5;
                    Shared.ndigits = 5;
                    isCustomButtonTapped = true;
                  });
              }else if(_selectedDifficulty == Difficulty.med){
                setState(() {
                  Shared.scoremultiDI = 3;
                  Shared.ndigits = 3;
                  isCustomButtonTapped = true;
                });
              }else{
                setState(() {
                  Shared.scoremultiDI = 1;
                  Shared.ndigits = 1;
                  isCustomButtonTapped = true;
                });
              }

              controller.loading();
              await Future.delayed(const Duration(seconds: 2));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const QuizScreen();
                  }),
                );
              controller.success();
            },
          ),
//////////// button 2

        SizedBox(height: 20.0),
        ActionSlider.standard(
            width: width * 0.6,
            backgroundColor: Colors.transparent,
            toggleColor: Color(0xffffffff),
            icon: Icon(
              Icons.play_arrow,
              color:  Color.fromARGB(255, 0, 42, 252),
              size: height * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width*0.08),

                Text(
                  _selectedDifficulty == Difficulty.easy  ? '?? ${Shared.op} ??':
                  _selectedDifficulty == Difficulty.med ? '???? ${Shared.op} ????':
                  '?????? ${Shared.op} ??????'

                    ,
                    style: TextStyle(
                        color: Color.fromARGB(255, 203, 213, 237),
                        fontSize: height*0.022,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            action: (controller) async {
              if(_selectedDifficulty == Difficulty.hard){
                  setState(() {
                    Shared.scoremultiDI = 6;
                    Shared.ndigits = 6;
                    isCustomButtonTapped = true;
                  });
              }else if(_selectedDifficulty == Difficulty.med){
                setState(() {
                  Shared.scoremultiDI = 4;
                  Shared.ndigits = 4;
                  isCustomButtonTapped = true;
                });
              }else{
                setState(() {
                  Shared.scoremultiDI = 2;
                  Shared.ndigits = 2;
                  isCustomButtonTapped = true;
                });
              }
              controller.loading();
              await Future.delayed(const Duration(seconds: 2));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const QuizScreen();
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
              Icons.arrow_back,
              color:  Color.fromARGB(255, 252, 0, 113),
              size: height * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width*0.08),

                Text("Back Menu",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 111, 0),
                        fontSize: height*0.022,
                        fontFamily: "impact")),
              ],
            ),
            action: (controller) async {
              controller.loading();
              await Future.delayed(const Duration(seconds: 2));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const OperationScreen();
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
                          color:  Color.fromARGB(255, 255, 230, 0),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Guidline',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 244, 244, 2),
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




/////// old
      //     if (_selectedDifficulty == Difficulty.easy)
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           SizedBox(height: 30),
      //         ],
      //       ),
      //     if (_selectedDifficulty == Difficulty.easy)
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '? ${Shared.op} ?',
      //               color: isCustomButtonTapped && Shared.ndigits == 1
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 1
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 1;
      //                   Shared.ndigits = 1;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '?? ${Shared.op} ??',
      //               color: isCustomButtonTapped && Shared.ndigits == 2
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 2
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 2;
      //                   Shared.ndigits = 2;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     if (_selectedDifficulty == Difficulty.med)
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           SizedBox(height: 30),
      //         ],
      //       ),
      //     if (_selectedDifficulty == Difficulty.med)
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '??? ${Shared.op} ???',
      //               color: isCustomButtonTapped && Shared.ndigits == 3
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 3
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 3;
      //                   Shared.ndigits = 3;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '???? ${Shared.op} ????',
      //               color: isCustomButtonTapped && Shared.ndigits == 4
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 4
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 4;
      //                   Shared.ndigits = 4;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     if (_selectedDifficulty == Difficulty.hard)
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           Icon(
      //             Icons.star_rate_rounded,
      //             color: Styles.blueColor,
      //             size: 32,
      //           ),
      //           SizedBox(height: 30),
      //         ],
      //       ),
      //     if (_selectedDifficulty == Difficulty.hard)
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '????? ${Shared.op} ?????',
      //               color: isCustomButtonTapped && Shared.ndigits == 5
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 5
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 5;
      //                   Shared.ndigits = 5;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //           const SizedBox(height: 15),
      //           SizedBox(
      //             width: double.infinity,
      //             child: CustomButton(
      //               buttonText: '?????? ${Shared.op} ??????',
      //               color: isCustomButtonTapped && Shared.ndigits == 6
      //                   ? customButtonColor
      //                   : null,
      //               textColor: isCustomButtonTapped && Shared.ndigits == 6
      //                   ? Styles.darkColor
      //                   : null,
      //               onTap: () {
      //                 setState(() {
      //                   Shared.scoremultiDI = 6;
      //                   Shared.ndigits = 6;
      //                   isCustomButtonTapped = true;
      //                 });
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     const SizedBox(height: 30),
      //     if (!isCustomButtonTapped)
      //       const SizedBox(
      //         height: 66,
      //       ),

      //     if (isCustomButtonTapped)
      //       SmallCustomButton(
      //         buttonText: 'NEXT',
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (BuildContext context) {
      //               return const QuizScreen();
      //             }),
      //           );
      //         },
      //       ),
        ],
      ),
   

      ),

    );
  }
}
