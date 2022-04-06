import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/filter_controller.dart';
import '../Util/constants.dart';

class HelpType extends StatefulWidget {
  const HelpType({
    Key? key,
  }) : super(key: key);

  @override
  State<HelpType> createState() => _HelpTypeState();
}

class _HelpTypeState extends State<HelpType> {
  List<String> type = ["الجمعيات الخيرية", "المتبرعين و المتطوعين"];
  List<String> service = [
    'التكفل بذوي الاحتياجات الخاصة',
    'مطاعم الرحمة',
    'قفة رمضان',
    'جمعيات التبرع بالدم',
    'مساعدة اليتامى'
  ];
  List<String> cont = [
    'ملابس',
    'مبلغ نقدي',
    'غذاء',
  ];
  List<String> selectedServices = [];

  int selectedService = 1;
  FilterController controller = Get.find<FilterController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(2, (index) => _item(index, type[index])),
        ),
        const SizedBox(
          height: 10,
        ),
        if (controller.filter.helpType == type[1])
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "نوع التبرع و التطوع",
                style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: List.generate(
                    cont.length, (index) => _itemCont(index, cont[index])),
              ),
            ],
          ),
        if (controller.filter.helpType == type[0])
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "نوع الخدمات الخيرية",
                style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: List.generate(service.length,
                    (index) => _itemService(index, service[index])),
              ),
            ],
          )
      ],
    );
  }

  Widget _itemCont(int index, String title) {
    bool selected = controller.filter.services!.contains(title);

    return GestureDetector(
      onTap: () {
        setState(() {
          selected
              ? controller.filter.services?.remove(title)
              : controller.filter.services?.add(title);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(7),
          child: Text(
            title,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              color: selected ? kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(kRadius),
              border:
                  Border.all(color: selected ? kPrimaryColor : Colors.black)),
        ),
      ),
    );
  }

  Widget _itemService(int index, String title) {
    bool selected = controller.filter.services!.contains(title);

    return GestureDetector(
      onTap: () {
        setState(() {
          selected
              ? controller.filter.services?.remove(title)
              : controller.filter.services?.add(title);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(7),
          child: Text(
            title,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              color: selected ? kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(kRadius),
              border:
                  Border.all(color: selected ? kPrimaryColor : Colors.black)),
        ),
      ),
    );
  }

  Widget _item(int index, String title) {
    bool selected = controller.filter.helpType == type[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.filter.helpType = type[index];

          controller.filter.services?.clear();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(7),
          child: Text(
            title,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              color: selected ? kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(kRadius),
              border:
                  Border.all(color: selected ? kPrimaryColor : Colors.black)),
        ),
      ),
    );
  }
}
