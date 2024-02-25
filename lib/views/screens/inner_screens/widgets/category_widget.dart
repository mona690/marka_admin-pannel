import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _categoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: CircularProgressIndicator(color: Colors.yellow.shade900),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No Categories\n Added yet',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
              ),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var categoryImage = data['image'] as String?;
            var categoryName = data['categoryName'] as String?;

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (categoryImage != null && categoryImage.isNotEmpty)
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          categoryImage,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    if (categoryName != null && categoryName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(categoryName),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
