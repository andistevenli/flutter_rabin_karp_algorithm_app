class RabinKarpAlgorithm {
  // Fungsi untuk menghitung hash dari suatu substring menggunakan metode Rabin-Karp
  static int hashString({required String substring, required int prime}) {
    int hashValue = 0;
    for (int i = 0; i < substring.length; i++) {
      hashValue = (hashValue * prime + substring.codeUnitAt(i)) %
          1000000007; // Menggunakan modulo besar untuk menghindari overflow
    }
    return hashValue;
  }

  // Fungsi untuk menghitung tingkat kemiripan dua string menggunakan Rabin-Karp
  static double rabinKarpSimilarity({
    required String conversionText,
    required String testerText,
  }) {
    const int k = 3;
    const int prime = 101;

    // Set untuk menyimpan hash substring di string conversionText
    Set<int> hashesS1 = {};
    // Set untuk menyimpan hash substring di string testerText
    Set<int> hashesS2 = {};

    // Hitung hash untuk semua substring panjang k pada conversionText
    for (int i = 0; i <= conversionText.length - k; i++) {
      String substring = conversionText.substring(i, i + k);
      int substringHash = hashString(substring: substring, prime: prime);
      hashesS1.add(substringHash);
    }
    // Hitung hash untuk semua substring panjang k pada testerText
    for (int i = 0; i <= testerText.length - k; i++) {
      String substring = testerText.substring(i, i + k);
      int substringHash = hashString(substring: substring, prime: prime);
      hashesS2.add(substringHash);
    }
    // Hitung jumlah substring yang cocok berdasarkan hash
    Set<int> commonHashes = hashesS1.intersection(hashesS2);
    double similarity =
        (commonHashes.length / hashesS1.union(hashesS2).length) * 100;
    return similarity;
  }
}
