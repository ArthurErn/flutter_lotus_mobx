import 'package:flutter/material.dart';

class ItemMenuBottom extends StatelessWidget {
  final IconData icon;
  final String text;
  final route;

  const ItemMenuBottom({Key key, this.icon, this.text, this.route}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => route));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Text(text,
                        style: TextStyle(fontSize: 11, color: Colors.white))
                  ],
                ),
              ),
            ),
            width: 86,
            //height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color.fromRGBO(21, 101, 192, 1),
            )));
  }
}
