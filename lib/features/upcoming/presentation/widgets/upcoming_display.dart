import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:flutter/material.dart';

class UpcomingDisplay extends StatelessWidget {
  final List<Upcoming> upcomingList;

  const UpcomingDisplay({Key key, this.upcomingList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            upcomingList[0].id.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: upcomingList.length == 1 ? _buildItemProduct(upcomingList[0], -1) : _buildGridViewProduct(upcomingList),
                // child: _buildItemProduct(upcomingList[0]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget _buildItemProduct(Upcoming upcoming ) {
    return RawMaterialButton(
      onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingDetailScreen(id: upcoming.id.toString(),),));
      },
      child: CachedNetworkImage(
        imageUrl: upcoming.posterArtUrl,
        imageBuilder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: url, fit: BoxFit.cover ),
            ),
            // width: 80,
            height: 120,
          );
        },
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }*/

  Widget _buildGridViewProduct(List<Upcoming> upcomingList) {
    return GridView.builder(
      shrinkWrap: true,
      primary: true,
      physics: ScrollPhysics(),
      itemCount: upcomingList.length,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 2/3
      ),
      itemBuilder: (context, index) {
        return _buildItemProduct(upcomingList[index], index);
      });
  }

  Widget _buildItemProduct(Upcoming upcoming, int index) {
    return RawMaterialButton(
      onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingDetailScreen(id: upcoming.id.toString(),),));
      },
      child: CachedNetworkImage(
        imageUrl: upcoming.posterArtUrl,
        imageBuilder: (context, url) {
          return index == -1
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: url, fit: BoxFit.fitHeight ),
                  ),
                  // width: 80,
                  height: MediaQuery.of(context).size.width,
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: url, fit: BoxFit.cover ),
                  ),
                  // width: 80,
                  // height: 120,
                );
        },
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
