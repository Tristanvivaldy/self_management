class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      image: "images/eating_disorder.jpg",
      title: "Makanan Sehat",
      description:
          "Memakan makanan sehat adalah salah satu kebutuhan penting. Dengan gizi yang tercukupi, maka kehidupan kita akan menjadi lebih sehat dan akan terhindar dari banyak macam penyakit!"),
  UnboardingContent(
      image: "images/healthy_people.jpg",
      title: "Kehidupan Sehat",
      description:
          "Kehidupan sehat akan meningkatkan imun tubuh sehingga kita dapat melawan berbagai macam jenis penyakit"),
  UnboardingContent(
      image: "images/self_care_concept.jpg",
      title: "Peduli Diri",
      description:
          "Cara memulai hidup sehat adalah dengan peduli dengan diri sendiri, kepedulian terhadap diri sendiri akan membuat tubuh sadar akan pentingnya kesehatan dalam kehidupan")
];
