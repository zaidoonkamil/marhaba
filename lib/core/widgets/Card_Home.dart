import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  const CardHome({
    super.key,
    required this.title,
    required this.desc,
    required this.image,
    required this.color,
    required this.color2,
    this.onTap,
  });

  final String title;
  final String desc;
  final String image;
  final Color color;
  final Color color2;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(image),
                      Text(title,style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color2,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                      )
                  ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        vertical: 12
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Color(0XFFFF5D60),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 9.0),
                              child: Text('انتقل الان',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                ),),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Expanded(
                            child: Text(desc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                            ),),
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
