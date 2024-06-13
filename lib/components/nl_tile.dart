import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsTile extends StatefulWidget {
  final String name;
  const NewsTile({super.key, required this.name});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'lib/Images/Football.png',
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('May 22, 2024')
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(),
        ],
      ),
    );
  }
}
