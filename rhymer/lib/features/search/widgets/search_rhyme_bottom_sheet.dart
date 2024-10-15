import 'package:flutter/material.dart';

import '../../../ui/ui.dart'; // Подключение UI компонентов

class SearchRhymeBottomSheet extends StatelessWidget {
  const SearchRhymeBottomSheet({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBottomSheet(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: theme.hintColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: 'Начни вводить слово...',
                              hintStyle: TextStyle(
                                  color: theme.hintColor.withOpacity(0.5)),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ))),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _onTapSearch(context); // Переносим сюда вызов
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: const Text('Слово из автокомплита'),
                  onTap: () {},
                    ),
                separatorBuilder: (context, _) => const Divider(
                      height: 1,
                    ),
                itemCount: 15),

          ),
        ],
      ),
    );
  }

  void _onTapSearch(BuildContext context) {
    if (controller.text.isNotEmpty) {

      Navigator.of(context).pop(controller.text);
    } else {
      print('Поисковый запрос пустой');
    }
  }
}




// @override
// _SearchRhymeBottomSheetState createState() => _SearchRhymeBottomSheetState();


// class _SearchRhymeBottomSheetState extends State<SearchRhymeBottomSheet> {
//   //final TextEditingController _controller = TextEditingController();
//   List<String> _rhymes = []; // Список рифм
//   bool _isLoading = false; // Идет ли загрузка
//
//   // Функция поиска рифм
//   void _searchRhymes(String word) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final apiClient = RhymerApiClient.create();
//       final rhymes = await apiClient.getRhymesList({"word": word});
//
//       setState(() {
//         _rhymes = rhymes; // Обновляем рифмы
//         _isLoading = false; // Остановка индикатора загрузки
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Ошибка при получении рифм: $e');
//     }
//   }


// import 'package:flutter/material.dart';
//
// import '../../../ui/ui.dart';
//
// class SearchRhymeBottomSheet extends StatelessWidget {
//   const SearchRhymeBottomSheet({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return AppBottomSheet(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: theme.hintColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12)),
//                         child: TextField(
//                           decoration: InputDecoration(
//                               hintText: 'Начни вводить слово...',
//                               hintStyle: TextStyle(
//                                   color: theme.hintColor.withOpacity(0.5)),
//                               contentPadding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide.none),
//                               border: const OutlineInputBorder(
//                                   borderSide: BorderSide.none)),
//                         ))),
//                 const SizedBox(width: 10),
//                 Container(
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                         color: theme.primaryColor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: const Icon(Icons.search, color: Colors.white))
//               ],
//             ),
//           ),
//           Divider(height: 1),
//           Expanded(
//             child: ListView.separated(
//                 itemBuilder: (context, index) => ListTile(
//                       title: const Text('jkdfglkjldgfkjlfgdkfjgd'),
//                   onTap: () {},
//                     ),
//                 separatorBuilder: (context, _) => const Divider(
//                       height: 1,
//                     ),
//                 itemCount: 15),
//           ),
//         ],
//       ),
//     );
//   }
// }
