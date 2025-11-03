class ProjectsModel {
  final String name;
  final String description;
  final String imageUrl;
  final String? githubLink;
  final String? androidLink;
  final String? iosLink;

  ProjectsModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    this.githubLink,
    this.androidLink,
    this.iosLink,
  });
}
