import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:launch_date_app/global.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList = [];

  getFavoriteListKeys() async {
    if (isFavoriteSentClicked) {
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("favoriteSent")
          .get();

      for (int i = 0; i < favoriteSentDocument.docs.length; i++) {
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteSentList);
    } else {
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("favoriteReceived")
          .get();

      for (int i = 0; i < favoriteReceivedDocument.docs.length; i++) {
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteReceivedList);
    }
  }

  getKeysDataFromUsersCollection(List<String> KeysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < KeysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            KeysList[k]) {
          favoritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favoritesList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFavoriteListKeys();
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
                  favoriteSentList.clear();
                  favoriteSentList = [];
                  favoriteReceivedList.clear();
                  favoriteReceivedList = [];
                  favoritesList.clear();
                  favoritesList = [];

                  isFavoriteSentClicked = true;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "My favourites",
                style: TextStyle(
                  color: isFavoriteSentClicked ? Colors.red : Colors.grey,
                  fontWeight: isFavoriteSentClicked
                      ? FontWeight.bold
                      : FontWeight.normal,
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
                  favoriteSentList.clear();
                  favoriteSentList = [];
                  favoriteReceivedList.clear();
                  favoriteReceivedList = [];
                  favoritesList.clear();
                  favoritesList = [];

                  isFavoriteSentClicked = false;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "I'm their Favourite",
                style: TextStyle(
                  color: isFavoriteSentClicked ? Colors.grey : Colors.red,
                  fontWeight: isFavoriteSentClicked
                      ? FontWeight.normal
                      : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: favoritesList.isEmpty
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
              children: List.generate(favoritesList.length, (index) {
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
                              favoritesList[index]["imageProfile"],
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
                                  favoritesList[index]["name"].toString() +
                                      " ⦾ " +
                                      favoritesList[index]["age"].toString(),
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
                                        favoritesList[index]["city"]
                                                .toString() +
                                            " , " +
                                            favoritesList[index]["country"]
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
