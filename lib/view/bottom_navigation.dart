import 'package:coding_hands_task/controller/homepage.dart';
import 'package:coding_hands_task/view/home_page.dart/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class BottomNavigationScreen extends ConsumerWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    const pages = [HomePage(),Scaffold(body: Center(child: Text("Search"),),),
    Scaffold(body: Center(child: Text("Orders"),)),
    Scaffold(body: Center(child: Text("More"),))];
    final currentPage = ref.watch(HomePageProvider.currentpage);
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          ref.read(HomePageProvider.currentpage.notifier).update((state) => value);
        },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.grey,
          selectedLabelStyle:const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: "Home")
          ]),
    );
  }
}
