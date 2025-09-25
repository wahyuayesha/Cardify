import 'package:cardify/features/generate_flashcard/presentation/pages/debug_page.dart';
import 'package:cardify/features/ocr/presentation/pages/debug_ocr_page.dart';
import 'package:cardify/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DebugPage(),
    );
  }
}



// class FlashcardList extends StatefulWidget {
//   const FlashcardList({super.key});

//   @override
//   State<FlashcardList> createState() => _FlashcardListState();
// }

// class _FlashcardListState extends State<FlashcardList> {
//   late List<Map<String, String>> kartu;
//   int kartuAktif = 0;

//   /// simpan index kartu yang ditandai
//   Set<int> ditandai = {};

//   @override
//   void initState() {
//     super.initState();
//     kartu = [
//       {
//         "soal": "Apa judul album debut Taylor Swift tahun 2006?",
//         "jawaban": "Taylor Swift",
//       },
//       {
//         "soal": "Album mana yang berisi lagu 'Love Story'?",
//         "jawaban": "Fearless",
//       },
//       {"soal": "Tahun rilis album '1989'?", "jawaban": "2014"},
//       {"soal": "Apa warna dominan cover album 'Red'?", "jawaban": "Merah"},
//       {
//         "soal": "Lagu pembuka di album 'Reputation'?",
//         "jawaban": "...Ready For It?",
//       },
//       {"soal": "Single utama dari album 'Midnights'?", "jawaban": "Anti-Hero"},
//       {"soal": "Apa judul album ke-10 Taylor Swift?", "jawaban": "Midnights"},
//       {
//         "soal": "Taylor Swift lahir di negara bagian?",
//         "jawaban": "Pennsylvania",
//       },
//       {
//         "soal": "Siapa sahabat yang sering disebut di lagu '22'?",
//         "jawaban": "Ashley, Claire, dan Selena",
//       },
//       {"soal": "Genre utama album 'Folklore'?", "jawaban": "Indie Folk"},
//       {
//         "soal":
//             "Album mana yang memenangkan Grammy 'Album of the Year' tahun 2021?",
//         "jawaban": "Folklore",
//       },
//       {
//         "soal": "Apa lagu paling populer dari album '1989'?",
//         "jawaban": "Shake It Off",
//       },
//       {
//         "soal": "Apa nama tur dunia Taylor Swift yang dimulai 2023?",
//         "jawaban": "The Eras Tour",
//       }
//     ]..shuffle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double progress = (kartuAktif + 1) / kartu.length;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flashcards Horizontal"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.star),
//             onPressed: () {
//               // buka halaman review
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ReviewPage(
//                     kartu: kartu,
//                     ditandai: ditandai,
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // progress bar
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: TweenAnimationBuilder<double>(
//               tween: Tween<double>(begin: 0, end: progress),
//               duration: const Duration(milliseconds: 500),
//               builder: (context, value, _) => LinearProgressIndicator(
//                 value: value,
//                 minHeight: 10,
//                 backgroundColor: Colors.grey[300],
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           Text(
//             "${(progress * 100).toStringAsFixed(0)}% selesai",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),

//           // flashcard
//           Expanded(
//             child: PageView.builder(
//               itemCount: kartu.length,
//               onPageChanged: (index) {
//                 setState(() => kartuAktif = index);
//               },
//               itemBuilder: (context, index) {
//                 final controller = FlipCardController();
//                 bool isMarked = ditandai.contains(index);

//                 return Column(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 40),
//                         child: FlipCard(
//                           controller: controller,
//                           rotateSide: RotateSide.right,
//                           axis: FlipAxis.vertical,
//                           onTapFlipping: true,
//                           frontWidget: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             color: Colors.blueAccent,
//                             elevation: 8,
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: Text(
//                                   kartu[index]['soal']!,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           backWidget: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             color: Colors.green,
//                             elevation: 8,
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: Text(
//                                   kartu[index]['jawaban']!,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // tombol tandai
//                     IconButton(
//                       icon: Icon(
//                         isMarked ? Icons.star : Icons.star_border,
//                         color: isMarked ? Colors.amber : Colors.grey,
//                         size: 30,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           if (isMarked) {
//                             ditandai.remove(index);
//                           } else {
//                             ditandai.add(index);
//                           }
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReviewPage extends StatelessWidget {
//   final List<Map<String, String>> kartu;
//   final Set<int> ditandai;

//   const ReviewPage({super.key, required this.kartu, required this.ditandai});

//   @override
//   Widget build(BuildContext context) {
//     final reviewKartu = ditandai.map((i) => kartu[i]).toList();

//     return Scaffold(
//       appBar: AppBar(title: const Text("Review Ulang")),
//       body: reviewKartu.isEmpty
//           ? const Center(child: Text("Belum ada kartu yang ditandai."))
//           : ListView.builder(
//               itemCount: reviewKartu.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: const Icon(Icons.star, color: Colors.amber),
//                   title: Text(reviewKartu[index]['soal']!),
//                   subtitle: Text("Jawaban: ${reviewKartu[index]['jawaban']}"),
//                 );
//               },
//             ),
//     );
//   }
// }
