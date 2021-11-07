import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie/model/movie.dart';

class MovieListView extends StatelessWidget {
  //const MovieListView({Key? key}) : super(key: key);

  final List<Movie> movieList = Movie.getMovies();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index){
            return Stack(
                children: <Widget>[
                  movieCard(movieList[index], context),
                  Positioned(
                    top: 10,
                      child: movieImage(movieList[index].images[0])
                  ),
                ]);
        // return Card(
        //   elevation: 4.5,
        //   color: Colors.white,
        //   child: ListTile(
        //     leading: CircleAvatar(
        //       child: Container(
        //         width: 200,
        //         height: 200,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage(movieList[index].images[0]),
        //             fit: BoxFit.cover,
        //           ),
        //           borderRadius: BorderRadius.circular(13.9),
        //         ),
        //
        //       ),
        //
        //     ),
        //     title: Text("${movieList[index].Title}"),
        //     subtitle: Text("${movieList[index].Released}"),
        //     trailing: Text("..."),
        //     //onTap:  ()=> debugPrint("Movie name: ${movies[index]}"),
        //     onTap: (){
        //       Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieListViewDetails(movieName: movieList[index].Title,movie:movieList[index] ,)));
        //     },
        //   ),
        // );
      })
    );
  }
Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 54),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                    Flexible(child: Text(movie.Title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),)),
                    Text("Rating: ${movie.imdbRating} / 10", style: mainTextStyle(),)
                  ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Released: ${movie.Released}", style: mainTextStyle()),
                      Text(movie.Runtime,style: mainTextStyle()),
                      Text(movie.Rated,style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: ()=> {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)=> MovieListViewDetails(movieName: movie.Title,movie: movie ,)))
        }
      ,
    );
}

TextStyle mainTextStyle(){
    return TextStyle(
        fontSize: 15, color: Colors.grey
    );
}

Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
          image : DecorationImage(
              image: NetworkImage(imageUrl ?? 'https://picsum.photos/'), // Generate random image if imageURl is invalid
              fit: BoxFit.cover
          )
      ),
    );
}
}

// New Route (Screen or Page)

class MovieListViewDetails extends StatelessWidget {

  final  String movieName;
  final Movie movie;

  const MovieListViewDetails({Key? key, required this.movieName, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text("Movies"),
      ),
      body: ListView(
        children: [
          MovieDetailsThumbNail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images)
        ],
      ),
    );
  }
}

class MovieDetailsThumbNail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbNail({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover
                )
              ),
            ),
            Icon(Icons.play_circle_outline, size:100, color: Colors.white,)
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
              begin: Alignment.topCenter,end: Alignment.bottomCenter),
            ),
        height: 80,
          ),
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeaderWithPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(width: 16,),
          Expanded(child: MovieDetailsHeader(movie:movie))

        ],
      ),
    );
  }
}


class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${movie.Year} . ${movie.Genre}".toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),),
        Text("${movie.Title}",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),),
        Text.rich(TextSpan(style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),
            children:[TextSpan( text: movie.Plot),
                      TextSpan(text: "More...", style: TextStyle(color: Colors.indigoAccent))

            ] ))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field :"Cast", value:movie.Actors),
          MovieField(field :"Directors", value:movie.Director),
          MovieField(field :"Awards", value:movie.Awards),
        ],
      ),
    );
  }
}
class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field : ", style:TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),),
        Expanded(child: Text(value, style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}
class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("More Movie Poster".toUpperCase(),style: TextStyle(fontSize: 14,color: Colors.black26),),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8,),
              itemCount: posters.length,
            itemBuilder: (context,index)=> ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width/4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.cover
                  )
                )

              ),

            ),
          ),
        )
      ],
    );
  }
}
