import 'package:application/game_X_O.dart';
import 'package:flutter/material.dart';

class you extends StatefulWidget
{

  @override
  State<you> createState() => _youState();
}
enum player{o,x}
class _youState extends State<you> {
  player current = player.x;
  var items =<player?>[null,null,null,null,null,null,null,null,null];
  player?winner;
  bool endgame = false;
  int counter =0;
  handelwinner(){
    const winnercase=[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],

    ];

    for (var element in winnercase) {
      final fItem = items[element[0]];
      final sItem = items[element[1]];
      final tItem = items[element[2]];
      if (fItem == sItem && fItem == tItem && fItem != null) {
        print(element);
        winner = fItem;
        endgame = true;
        break;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          ' Sigh (3 * 3) game',
          style:TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        actions: [IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return you();
            },));
          },
          icon:Icon(Icons.restart_alt),
          color: Colors.black,
          iconSize: 35.0,
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0
        ),
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.all(8.0),


          child: Text("current player is ${current.name}",
              style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w900,
              fontSize: 34.0
              )
          ),

          ),
if(winner != null) Text("The winner is ${winner!.name}",
style: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w900,
    fontSize: 34.0
),
),
if(endgame && winner == null) const Text("no winner",
style: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w900,
    fontSize: 34.0
),),

bord(items: items,
    onClick: (i) {
      if(endgame) return;
      if(items[i] != null){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("please select empty location")));
        return;
      }
      setState(() {
        counter++;
        items[i]=current;
        current = current == player.x? player.o :player.x;
        handelwinner();
        if(winner == null && !items.contains(null)){
          endgame=true;
        }


      });

    },

)
          ],
        ),
      ),
    );
  }
}
class bord extends StatelessWidget
{
  final List<player?> items;
  final void Function(int) onClick;


 const  bord(  {super.key,required this.items,
   required this.onClick,

  });

  @override
  Widget build(BuildContext context) {
   return GridView(
         shrinkWrap: true,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 3,
         mainAxisSpacing: 10,
         crossAxisSpacing: 10
       ),

      children: [
        for(int i=0; i< items.length; i++)
          InkWell(onTap: () {
            onClick(i);
          },
          child:Container(
          color: Colors.black,
            child: borditem(item: items[i],),

         )

          ),


      ],

   );

  }

}
class borditem extends StatelessWidget
{
  final player? item;
  borditem({super.key,required this.item});
  @override
  Widget build(BuildContext context) {
    if(item==null) return SizedBox();
    return Center(
      child: Text(
        item!.name,
        style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),

      ),
    );

  }

}