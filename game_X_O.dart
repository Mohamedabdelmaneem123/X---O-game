import 'package:flutter/material.dart';

 class game extends StatefulWidget
{


  @override
  State<game> createState() => _gameState();
}
enum player{x,o}
class _gameState extends State<game> {

   player current = player.o;
   var items=<player?>[null,null,null,null,null, null,null,null,null];
   player? winner;
   bool endGame = false;
   int counter = 0;

   handleWinner() {
     const winnerCase = [
       [0, 1, 2],
       [3, 4, 5],
       [6, 7, 8],
       [0, 3, 6],
       [1, 4, 7],
       [2, 5, 8],
       [0, 4, 8],
       [2, 4, 6],
     ];
     for (var element in winnerCase) {
       final fItem = items[element[0]];
       final sItem = items[element[1]];
       final tItem = items[element[2]];
       if (fItem == sItem && fItem == tItem && fItem != null) {
         print(element);
         winner = fItem;
         endGame = true;
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
         'X or O game',
         style:TextStyle(
           fontSize: 40.0,
           fontWeight: FontWeight.bold,
           color: Colors.black
         ),
       ),
       actions: [IconButton(
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return game();
             },));
           },
           icon:Icon(Icons.restart_alt),
       color: Colors.black,
         iconSize: 35.0,
       )],
     ),
     body: Padding(
       padding: const EdgeInsets.symmetric(
         vertical: 25.0
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
               ),),

           ),
           if (winner != null) Text("the winner is ${winner!.name}",
           style: TextStyle(
             color: Colors.red,
             fontWeight: FontWeight.w900,
             fontSize: 34.0
           ),),
           if (endGame && winner == null) const Text("no winner",
                   style: TextStyle(
                       color: Colors.red,
                       fontWeight: FontWeight.w900,
                       fontSize: 34.0
                       ),),

           Board(
             items: items,
             onClick: (i) {
               if (endGame) return;

               if (items[i] != null) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                     content: Text("please select empty location")));
                 return;
               }

               setState(() {
                 counter++;
                 items[i] = current;
                 current = current == player.o ? player.x : player.o;
                 handleWinner();
                 if (winner == null && !items.contains(null)) {
                   endGame = true;
                 }
               });
             },
           ),

         ],

       ),
     ),
   );
  }
}

class Board extends StatelessWidget {
  final List<player?> items;
  final void Function(int) onClick;
  const Board({super.key, required this.items, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
      children: [
        for (int i = 0; i < items.length; i++)
          InkWell(
            onTap: () {
              onClick(i);
            },
            child: Container(
              color: Colors.blue,
              child: BoardItem(item: items[i]),
            ),
          )
      ],
    );
  }
}
class BoardItem extends StatelessWidget {
  final player? item;
  const BoardItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    if (item == null) return const SizedBox();
    return Center(
      child: Text(
        item!.name,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }
}
