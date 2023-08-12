import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  generateSvgPathsClass();
}

void generateSvgPathsClass() {
  const svgDirectoryPath = 'assets/icons'; // Replace with your SVG folder path
  const outputFilePath =
      'lib/utils/icons.dart'; // Change to your desired output path

  final directory = Directory(svgDirectoryPath);

  if (!directory.existsSync()) {
    print("SVG directory doesn't exist.");
    return;
  }

  final svgFiles = directory
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.svg'));

  final classContent = StringBuffer();

  classContent.writeln('class MarloIcons {');

  for (final svgFile in svgFiles) {
    final fileName = path.basename(svgFile.path);
    final relativePath = path.relative(svgFile.path, from: 'lib');
    final staticFieldName =
        fileName.replaceAll('.svg', '').replaceAll('-', '_');

    classContent
        .writeln('  static const String $staticFieldName = \'$relativePath\';');
  }

  classContent.writeln('}');

  final outputFile = File(outputFilePath);
  outputFile.writeAsStringSync(classContent.toString());

  print('SVG paths class generated successfully at: $outputFilePath');
}
