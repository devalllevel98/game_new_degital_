import 'dart:async';
import 'dart:io';

import 'package:animated_background/animated_background.dart';
import 'package:degitalgame/gui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../calculations/quiz_maker.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/styles/styles.dart';
import '../shared/utils/keyboard_utils.dart';
import '../shared/utils/shared_prefs.dart';
import 'operation_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late Timer _timer;
  late int _timerSeconds =
      Shared.ndigits * Shared.scoremultiDI * Shared.scoremultiOP * 5;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          timer.cancel();
        });

        if (Shared.score == null) {
          setState(() {
            Shared.score = 0;
          });
        }
        if (!isAnswerCorrect) {
          setState(() {
            Shared.score -= Shared.ndigits;
            saveVariableToSharedPreferences('userScore', Shared.score);
            getSavedValueFromSharedPreferences('userScore');
          });
        }

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const QuizScreen();
        }));
        // Add any logic you want to execute when the timer reaches 0.
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  Color inputIndicate = Styles.blueColor;
  TextEditingController inputController = TextEditingController();
  bool isAnswerCorrect = false;
  QuizMaker quiz = QuizMaker(Shared.ndigits, Shared.op);
  late String problem;
  late int result;
  late FocusNode inputFocusNode;

  void hideKeyboardOnHomeTap() {
    KeyboardUtils.hideKeyboard();
  }

  @override
  void initState() {
    super.initState();
    inputFocusNode = FocusNode();
    generateProblem();

    // Delay the focus request until after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(inputFocusNode);
      startTimer();
    });
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    stopTimer();
    super.dispose();
  }

  void generateProblem() {
    setState(() {
      problem = quiz.problem;
      result = quiz.result;
      isAnswerCorrect = false;
      inputController.text = '';
    });
  }

  void checkAnswer() {
    String input = inputController.text;
    setState(() {
      isAnswerCorrect = input == quiz.result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
      getSavedValueFromSharedPreferences('userScore');
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
            // baseColor: Colors.blue,
            image: Image(image: AssetImage('assets/logoani.png')),
          ),
        ),
        vsync: this,
        child:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Question ?',
                    style: TextStyle(
                      fontFamily: 'impact',
                      color: Styles.whiteColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            problem,
                            style: const TextStyle(
                              // fontFamily: 'Dekko',
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 35,
                              fontFamily: "impact"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints:BoxConstraints.expand(height: 110),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: TextFormField(
                          style: const TextStyle(
                            color: Styles.blueColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          controller: inputController,
                          keyboardType: TextInputType.number,
                          focusNode: inputFocusNode,
                          decoration: InputDecoration(
                            prefix: Visibility(
                                visible: isAnswerCorrect,
                                child: Icon(
                                  CupertinoIcons.checkmark_rectangle_fill,
                                  color: CupertinoColors.activeGreen,
                                )),
                            suffix: Visibility(
                                visible: isAnswerCorrect,
                                child: Icon(
                                  CupertinoIcons.checkmark_rectangle_fill,
                                  color: CupertinoColors.activeGreen,
                                )),
                            alignLabelWithHint: true,
                            hintText: 'Your answer ?',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 179, 233, 147).withOpacity(0.5),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onChanged: (_) {
                            setState(() {
                              isAnswerCorrect = false;
                            });
                          },
                          onFieldSubmitted: (_) {
                            checkAnswer();
                            if (isAnswerCorrect) {
                              setState(() {
                                _timer.cancel();
                                Shared.score += 10 *
                                    (Shared.scoremultiDI * Shared.scoremultiOP);
                                saveVariableToSharedPreferences(
                                    'userScore', Shared.score);
                                getSavedValueFromSharedPreferences('userScore');
                                inputIndicate = Colors.green;
                              });
                            }
                          }),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Time: ", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "impact"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   CupertinoIcons.timer,
                      //   color: Styles.pinkColor,
                      //   size: 20,
                      // ),
                      const SizedBox(width: 10),
                      Text('$_timerSeconds s', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "impact"),),

                    ],
                  ),
                    ],
                  ),
                    ElevatedButton(
                          child: const Text('Check', style: TextStyle(
                          color:  Color.fromARGB(255, 244, 2, 2),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {
                        checkAnswer();
                          if (isAnswerCorrect) {
                            setState(() {
                              _timer.cancel();
                              Shared.score +=
                                  10 * (Shared.scoremultiDI * Shared.scoremultiOP);
                              saveVariableToSharedPreferences('userScore', Shared.score);
                              getSavedValueFromSharedPreferences('userScore');
                              // inputIndicate = Colors.green;
                            });
                          }
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                ),
                  //// score
                   Row(
                    children: [
                      Text("Score: ", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "impact"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   CupertinoIcons.timer,
                      //   color: Styles.pinkColor,
                      //   size: 20,
                      // ),
                      const SizedBox(width: 10),
                      Text('${Shared.score}', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "impact"),),

                    ],
                  ),
                    ],
                  ),
              
                ],
              ),
               SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    isAnswerCorrect ? ElevatedButton(
                          child: const Text('Next', style: TextStyle(
                          color: Color.fromARGB(255, 244, 2, 2),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const QuizScreen();
                            }),
                          );
                        
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                      ),
                ):ElevatedButton(
                          child: const Text('Next', style: TextStyle(
                          color: Color.fromARGB(255, 42, 39, 39),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {
                        print("sai");
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                      ),
                ),
                  //// score
                    ElevatedButton(
                          child: const Text('Back Menu', style: TextStyle(
                          color:  Color.fromARGB(255, 244, 2, 2),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => OperationScreen()),
                          );
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                ),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                     ElevatedButton(
                          child: const Text('Guideline', style: TextStyle(
                          color: Color.fromARGB(255, 244, 2, 2),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return Guiline();
                            }),
                          );
                        
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                      ),
                ),
                  //// score
                    ElevatedButton(
                          child: const Text('Quit App', style: TextStyle(
                          color:  Color.fromARGB(255, 244, 2, 2),
                          fontSize: 20,
                          fontFamily: 'impact'
                          ),),
                      onPressed: () {
                          exit(0);
                          },
                      style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                      ),
                ),

                ],
              ),

            ],
          ),
        ),
      ),
   

      ),


    );
  }
}
