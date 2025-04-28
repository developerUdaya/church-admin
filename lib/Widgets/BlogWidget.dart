import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Commandbob.dart';

class Blogwidget extends StatelessWidget {
  final String name;
  const Blogwidget({super.key,this.name = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
      margin: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFF4F7FB),
      ),
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleRow(title: name),
            SizedBox(height: 30),
            Container(
              //padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/blog.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('2 min Read',
                            style: GoogleFonts.manrope(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text('Health',
                                    style: GoogleFonts.manrope(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: Text(
                                'Early Black Friday Amazon deals: cheap TVs, headphones, laptops',
                                style: GoogleFonts.manrope(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_sharp,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '2332',
                                      style: GoogleFonts.manrope(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.message,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '3',
                                      style: GoogleFonts.manrope(fontSize: 15),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Wed, Jan 22',
                                      style: GoogleFonts.manrope(fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Title of the paragraph',
                                style: GoogleFonts.manrope(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'But you cannot figure out what it is or what it can do. MTA web directory is the simplest way in which one can bid on a link, or a few links if they wish to do so. The link directory on MTA displays all of the links it currently has, and does so in alphabetical order, which makes it much easier for someone to find what they are looking for if it is something specific and they do not want to go through all the other sites and links as well. It allows you to start your bid at the bottom and slowly work your way to the top of the list.\n\nGigure out what it is or what it can do. MTA web directory is the simplest way in which one can bid on a link, or a few links if they wish to do so. The link directory on MTA displays all of the links it currently has, and does so in alphabetical order, which makes it much easier for someone to find what they are looking for if it is something specific and they do not want to go through all the other sites and links as well. It allows you to start your bid at the bottom and slowly work your way to the top of the',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text('This is strong text.',
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text('This is italic text.',
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontStyle: FontStyle.italic)),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Unorder list.',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            ...List.generate(6, (index) {
                              return Text('• Item ${index + 1}',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                  ));
                            }),
                            SizedBox(height: 20),
                            Divider(),
                            SizedBox(height: 20),
                            Text(
                              'Order list.',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            ...List.generate(6, (index) {
                              return Text('${index + 1}. Item ${index + 1}',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                  ));
                            }),
                            SizedBox(height: 20),
                            Divider(),
                            SizedBox(height: 20),
                            Text(
                              'Quotes',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  // Left border
                                  Container(
                                    width: 5.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.format_quote_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          Text(
                                            '“Life is short, Smile while you still have teeth!”',
                                            style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(28),
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Comments',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                    ),
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF635bff)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Post Comment',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Comments',
                        style: GoogleFonts.manrope(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '3',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CommentCard(
                            username: index == 0 ? 'Lula Boyd' : 'Bettie Marsh',
                            comment: index == 0
                                ? 'Gosiblo iluw mumwog vewkito si ko iva so do jebdar mo dalaco ijumub noduomi tikilu. Bin gi hiowe bed pospo zorid fahinwa defu bod uhdufos canusgez mejzora ka tabebbi tit.'
                                : 'Dukig kowwa fawluajo vuzvitmo ca piana ru joz susifo pi ah irtalor afu wasjoura cu sijlosdiz. Uzunekwes lewute hegur rucmite zimotook uzmujnu vontib wuoknok pime gadaica dowase simsad wavu woat.',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
