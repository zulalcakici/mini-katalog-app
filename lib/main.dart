import 'package:flutter/material.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 144, 9, 61)),
        useMaterial3: true,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  // Sepetteki ürün sayısını tutan değişken (State yönetimi)
  int sepetUrunSayisi = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> urunler = [
      {'ad': 'Kablosuz Kulaklık', 'fiyat': '1.299 TL', 'ikon': Icons.headphones, 'detay': 'Yüksek ses kalitesi ve aktif gürültü engelleme özellikli kablosuz kulaklık.'},
      {'ad': 'Mouse', 'fiyat': '869 TL', 'ikon': Icons.mouse, 'detay': 'Ergonomik tasarımı ve yüksek hassasiyetiyle dikkat çeken mouse.'},
      {'ad': 'Mekanik Klavye', 'fiyat': '1.899 TL', 'ikon': Icons.keyboard, 'detay': 'RGB aydınlatmalı, mekanik tuş anahtarlarına sahip oyuncu klavyesi.'},
      {'ad': 'Bluetooth Hoparlör', 'fiyat': '999 TL', 'ikon': Icons.speaker, 'detay': 'Suya dayanıklı gövde ve güçlü bas performansına sahip taşınabilir hoparlör.'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 193),
        title: const Text(
          'Mini Katalog - Ürünler',
          style: TextStyle(color: Color.fromARGB(255, 144, 9, 61)),
        ),
        actions: [
          // Sepet İkonu ve Sayaç Rozeti
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 144, 9, 61)),
                const SizedBox(width: 4),
                Text(
                  '$sepetUrunSayisi',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 144, 9, 61),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: urunler.length,
          itemBuilder: (context, index) {
            final urun = urunler[index];

            return InkWell(
              onTap: () async {
                // Detay sayfasına git ve sepete ekleme bilgisini bekle
                final sepeteEklendiMi = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UrunDetaySayfasi(
                      urunAdi: urun['ad'].toString(),
                      urunFiyati: urun['fiyat'].toString(),
                      urunIkonu: urun['ikon'] as IconData,
                      urunAciklamasi: urun['detay'].toString(),
                    ),
                  ),
                );

                // Eğer detay sayfasından sepete ekle denilerek dönüldüyse sayacı artır
                if (sepeteEklendiMi == true) {
                  setState(() {
                    sepetUrunSayisi++;
                  });
                }
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 248, 193),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              urun['ikon'] as IconData,
                              size: 50,
                              color: const Color.fromARGB(255, 144, 9, 61),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        urun['ad'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        urun['fiyat'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// ÜRÜN DETAY SAYFASI
// ---------------------------------------------------------
class UrunDetaySayfasi extends StatelessWidget {
  final String urunAdi;
  final String urunFiyati;
  final IconData urunIkonu;
  final String urunAciklamasi;

  const UrunDetaySayfasi({
    super.key,
    required this.urunAdi,
    required this.urunFiyati,
    required this.urunIkonu,
    required this.urunAciklamasi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 193),
        title: Text(
          urunAdi,
          style: const TextStyle(color: Color.fromARGB(255, 144, 9, 61)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 248, 193),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                urunIkonu,
                size: 90,
                color: const Color.fromARGB(255, 144, 9, 61),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              urunAdi,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              urunFiyati,
              style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ürün Açıklaması',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                urunAciklamasi,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const Spacer(),
            // SEPETE EKLE BUTONU
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 144, 9, 61),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Geri dönerken true (sepete eklendi) bilgisini ana sayfaya gönderiyoruz
                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Sepete Ekle',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}