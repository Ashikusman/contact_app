import'package:flutter/material.dart';

import '../model/Contact.dart';

class ViewContact extends StatefulWidget {
  final Contact contact;
  const ViewContact({Key? key,required this.contact}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Contents Buddy'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children:  [
            const SizedBox(
              height: 30,
            ),
            const Text('Contact details',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                  color: Colors.cyan,
                  fontWeight: FontWeight.w600,
                ),
            ),
            SizedBox(
              height: 20,
              width: 100.0,
              child: Divider(
                color: Colors.cyan.shade100,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Name',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )
                ),
                Text(widget.contact.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
                Text(widget.contact.number ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
                Text(widget.contact.email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
