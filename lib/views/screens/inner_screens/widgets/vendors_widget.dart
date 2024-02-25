import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class VendorWidget extends StatefulWidget {
  @override
  _VendorWidget createState() => _VendorWidget();
}

class _VendorWidget extends State<VendorWidget> {
  final Stream<QuerySnapshot> _orderStrem =
      FirebaseFirestore.instance.collection('vendors').snapshots();

  Widget vendorData(Widget widget, int? flex) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _orderStrem,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) {
            final vendor = snapshot.data!.docs[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vendorData(
                    Container(
                      height: 50,
                      width: 50,
                      child: vendor['storeImage'] == ""
                          ? Image.network(
                              "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png")
                          : Image.network(
                              vendor['storeImage'],
                              width: 50,
                              height: 50,
                            ),
                    ),
                    1),
                vendorData(
                    Text(
                      vendor['companyName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    3),
                vendorData(
                    Text(vendor['address'],
                      
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                vendorData(
                    Text(
                      vendor['email'],
                    ),
                    2),
                vendorData(
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                            await FirebaseFirestore.instance.collection('vendors').doc(vendor.id).delete();
                         /*  // You may need to use a proper email sending mechanism here.
    // The following is just a placeholder.
    try {
      // Example: Sending a dummy email
      // Note: This is just an example and won't work in a real scenario without proper email sending setup.
      // You may want to use a package like 'mailer' for sending emails.
      // Make sure to handle email sending asynchronously to avoid blocking the UI thread.
      // Replace the placeholder with your email sending logic.
      final Email email = Email(
        body: 'Your vendor application has been rejected.',
        subject: 'Vendor Application Rejected',
        recipients: [vendor['email']],
        // You may need additional parameters based on your email sending setup.
      );

      await FlutterEmailSender.send(email);
    } catch (e) {
      // Handle the email sending error, if any.
      print('Error sending email: $e');
    }*/
                      },
                      child: Text(
                        'reject',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    1),
              ],
            );
          }),
        );
      },
    );
  }
}
