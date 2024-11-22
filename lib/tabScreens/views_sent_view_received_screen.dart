import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:launch_date_app/global.dart';

class ViewsSentViewReceivedScreen extends StatefulWidget {
  const ViewsSentViewReceivedScreen({super.key});

  @override
  State<ViewsSentViewReceivedScreen> createState() =>
      _ViewsSentViewReceivedScreenState();
}

class _ViewsSentViewReceivedScreenState
    extends State<ViewsSentViewReceivedScreen> {
  bool isViewSentClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewsList = [];

  getViewedListKeys() async {
    if (isViewSentClicked) {
      var viewSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("viewSent")
          .get();

      for (int i = 0; i < viewSentDocument.docs.length; i++) {
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewSentList);
    } else {
      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("viewReceived")
          .get();

      for (int i = 0; i < viewReceivedDocument.docs.length; i++) {
        viewReceivedList.add(viewReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewReceivedList);
    }
  }

  getKeysDataFromUsersCollection(List<String> KeysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < KeysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            KeysList[k]) {
          viewsList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewsList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getViewedListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  viewSentList.clear();
                  viewSentList = [];
                  viewReceivedList.clear();
                  viewReceivedList = [];
                  viewsList.clear();
                  viewsList = [];

                  isViewSentClicked = true;
                });
                getViewedListKeys();
              },
              child: Text(
                "My Views",
                style: TextStyle(
                  color: isViewSentClicked ? Colors.red : Colors.grey,
                  fontWeight:
                      isViewSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
            const Text(
              "   |   ",
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  viewSentList.clear();
                  viewSentList = [];
                  viewReceivedList.clear();
                  viewReceivedList = [];
                  viewsList.clear();
                  viewsList = [];

                  isViewSentClicked = false;
                });
                getViewedListKeys();
              },
              child: Text(
                "Viewed my profile",
                style: TextStyle(
                  color: isViewSentClicked ? Colors.grey : Colors.red,
                  fontWeight:
                      isViewSentClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: viewsList.isEmpty
          ? Center(
              child: Icon(
                Icons.person_off_sharp,
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(viewsList.length, (index) {
                return GridTile(
                    child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    color: Colors.blue.shade200,
                    child: GestureDetector(
                      onTap: () {},
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              viewsList[index]["imageProfile"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                //name
                                Text(
                                  viewsList[index]["name"].toString() +
                                      " ⦾ " +
                                      viewsList[index]["age"].toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                //icon-city-country
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    Expanded(
                                      child: Text(
                                        viewsList[index]["city"].toString() +
                                            " , " +
                                            viewsList[index]["country"]
                                                .toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
              }),
            ),
    );
  }
}
