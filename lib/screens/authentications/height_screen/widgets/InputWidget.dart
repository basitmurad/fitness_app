import 'package:flutter/material.dart';
import '../../../../utils/constants/AppColor.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.dark,
    required this.focusNode,
    required this.editingController,
    required this.opacity,
    this.ft,
    this.inch, required this.onChanged,
  });

  final bool dark;
  final FocusNode focusNode;
  final TextEditingController editingController;
  final double opacity;
  final String? ft;
  final String? inch;
  final Function(String) onChanged; // Add this line

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Rounded corners for Container
        child: Container(
          width: ft != null && inch != null ? 160 : 100,
          color: AppColor.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First field (ft or cm)
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: onChanged, // Add this line

                  style: const TextStyle(color: Colors.white),
                  controller: editingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: ft ?? 'cm',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: AppColor.lightBlue,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              if (ft != null && inch != null) ...[
                const SizedBox(width: 10),
                // Second field (inch)
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintText: 'inch',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: AppColor.lightBlue,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
