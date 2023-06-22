import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antoh/screens/login_screen.dart';

class Sliderimg extends StatefulWidget {
  const Sliderimg({ Key? key }) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Sliderimg> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  final List<dynamic> _Slider = [
    {
      'title': 'HOME \nsweet-home',
      'sub_title': 'Choose From Thousands Of Houses That Fits Your Choice.',
      'image': 'https://images.unsplash.com/photo-1479839672679-a46483c0e7c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=710&q=80'
    },
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this
  )..repeat(reverse: true);

  late final Animation<double> _animation = Tween<double>(
    begin: 1.0,
    end: 1.5
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear
  ));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.network(
                    _Slider[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.1)
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child: Text(_Slider[index]['title'], 
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                            color: Colors.white, 
                            fontSize: 42, 
                            fontWeight: FontWeight.bold
                          ),
                          ) 
                        ),
                      ),
                      const SizedBox(height: 10,),
                      FadeInDown(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 800),
                        child: Text(_Slider[index]['sub_title'], 
                          style:  TextStyle(
                            color: Colors.grey.shade100, 
                            fontSize: 18,
                          ),
                        )
                      ),
                      const SizedBox(height: 50,),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 1000),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                            ),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              LoginScreen()), (Route<dynamic> route) => false);
                            },
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.only(right: 5, left: 30, top: 5, bottom: 5),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                children: [
                                  Text('Get Started', 
                                    style: TextStyle(
                                      color: Colors.cyan.shade50, 
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.shade700,
                                      borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Icon(Icons.arrow_forward, color: Colors.cyan.shade100,)
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                      ), 
                      const SizedBox(height: 50),
                    ]
                  )
                ),
              )
            ],
          );
        },
        itemCount: _Slider.length,
      ),
    );
  }
}