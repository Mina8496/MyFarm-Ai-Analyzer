import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Related_Images extends StatelessWidget {
  const Related_Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Images',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 70,
                color: Colors.green.shade100,
                child: const Icon(Icons.image, color: Colors.green),
              ),
            ),
          ),
        ),
      ],
    );
  }
}