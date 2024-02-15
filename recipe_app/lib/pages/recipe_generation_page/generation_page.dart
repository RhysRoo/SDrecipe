import 'package:flutter/material.dart';

class GenerationPage extends StatelessWidget {
  const GenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Generation Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.009),
              Container(
                //Ui Panel Height & Width
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.95,

                decoration: BoxDecoration(
                  //Ui Panel Styling
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal[600],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Text('Generate Recipe 1', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.deepOrange,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_back, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.generating_tokens, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward, size: 40),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //Currently Selected Recipe
                        height: 50,
                        width: 400,
                        color: Colors.purple,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Colors.deepOrange)),
                        ),
                      ),
                      //recipe 2
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text('Generate Recipe 2', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.deepOrange,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_back, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.generating_tokens, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward, size: 40),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //Currently Selected Recipe
                        height: 50,
                        width: 400,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text('Generate Recipe 3', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.deepOrange,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_back, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.generating_tokens, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward, size: 40),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //Currently Selected Recipe
                        height: 50,
                        width: 400,
                        color: Colors.purple,
                      ),
                      //recipe 2
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text('Generate Recipe 4', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.deepOrange,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_back, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.yellow,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.generating_tokens, size: 40),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.27,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward, size: 40),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //Currently Selected Recipe
                        height: 50,
                        width: 400,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Lets Generate Them Recipes!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
