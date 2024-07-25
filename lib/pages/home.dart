import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'day.jpeg' : 'night.jpeg';
    Color? bgColor = data['isDayTime'] ? Colors.cyan[800] : Colors.black38;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 320.0, 0, 0),
              child: Column(
                      children: <Widget>[
              TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: const Icon(Icons.edit_location,
                  color: Colors.white),
                  label: Text('Choose location',
                  style: TextStyle(
                    color: Colors.grey[300]
                  ),)),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: const TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white
                    ),
                  )
                ],
              ),
                        const SizedBox(height: 20.0),
                        Text(
                          data['time'],
                          style: const TextStyle(
                            fontSize: 66.0,
                            color: Colors.white
                          )
                        )
                      ],
                    ),
            ),
          )),
    );
  }
}
