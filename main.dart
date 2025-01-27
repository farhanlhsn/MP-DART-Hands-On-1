import 'dart:io';

class Node {
  String kategori;
  double harga;
  Node? next;

  Node(this.kategori, this.harga);
}

class LinkedList {
  Node? head;

  bool get isEmpty => head == null;

  void add(String kategori, double harga) {
    final newNode = Node(kategori, harga);
    if (isEmpty) {
      head = newNode;
    } else {
      var current = head;
      while (current!.next != null) {
        current = current.next;
      }
      current.next = newNode;
    }
  }

  bool remove(String kategori, double harga) {
    if (isEmpty) return false;

    if (head!.kategori == kategori && head!.harga == harga) {
      head = head?.next;
      return true;
    }

    var current = head;
    while (current!.next != null) {
      if (current.next!.kategori == kategori && current.next!.harga == harga) {
        current.next = current.next?.next;
        return true;
      }
      current = current.next;
    }
    return false;
  }

  void printList() {
    var current = head;
    if (isEmpty) {
      print("Belum ada transaksi.");
      return;
    }
    while (current != null) {
      print("${current.kategori}: Rp${current.harga.toStringAsFixed(2)}");
      current = current.next;
    }
  }

  double totalPengeluaran() {
    double total = 0;
    var current = head;
    while (current != null) {
      total += current.harga;
      current = current.next;
    }
    return total;
  }

  void printByCategory(String kategori) {
    var current = head;
    bool found = false;
    while (current != null) {
      if (current.kategori == kategori) {
        print("${current.kategori}: Rp${current.harga.toStringAsFixed(2)}");
        found = true;
      }
      current = current.next;
    }
    if (!found) {
      print("Tidak ada transaksi dengan kategori '$kategori'.");
    }
  }
}

double getInitialBudget() {
  while (true) {
    try {
      print("Masukkan jumlah uang awal:");
      String input = stdin.readLineSync() ?? '';
      double budget = double.parse(input);
      if (budget <= 0) {
        print("Jumlah harus lebih besar dari 0.");
        continue;
      }
      return budget;
    } catch (e) {
      print("Input tidak valid. Masukkan angka.");
    }
  }
}

void main() {
  print("====================");
  print("    Money Tracker");
  print("====================");
  
  double initialBudget = getInitialBudget();
  LinkedList list = LinkedList();
  
  while (true) {
    print("\nMenu:");
    print("1. Cek sisa uang");
    print("2. Tambah transaksi");
    print("3. Buang transaksi");
    print("4. Cetak semua transaksi");
    print("5. Cetak transaksi per kategori");
    print("0. Keluar");
    print("====================");
    
    try {
      print("Masukkan pilihanmu:");
      String? pilih = stdin.readLineSync();

      switch (pilih) {
        case '1':
          cekUang(list, initialBudget);
          break;
        case '2':
          tambahTransaksi(list);
          break;
        case '3':
          buangTransaksi(list);
          break;
        case '4':
          printSemua(list);
          break;
        case '5':
          printByKategori(list);
          break;
        case '0':
          print("Sayonara!");
          return;
        default:
          print("Pilih yang bener, le!");
      }
    } catch (e) {
      print("Terjadi error: $e");
    }
  }
}

void cekUang(LinkedList list, double initialBudget) {
  double total = list.totalPengeluaran();
  double sisa = initialBudget - total;
  print("Sisa uang: Rp${sisa.toStringAsFixed(2)}");
}

void tambahTransaksi(LinkedList list) {
  try {
    print("Masukkan kategori transaksi:");
    String kategori = stdin.readLineSync()?.trim() ?? '';
    if (kategori.isEmpty) {
      print("Kategori tidak boleh kosong!");
      return;
    }

    print("Masukkan jumlah pengeluaran:");
    double harga = double.parse(stdin.readLineSync()!);
    if (harga <= 0) {
      print("Jumlah harus lebih besar dari 0!");
      return;
    }

    list.add(kategori, harga);
    print("Transaksi berhasil ditambahkan!");
  } catch (e) {
    print("Input tidak valid: $e");
  }
}

void buangTransaksi(LinkedList list) {
  try {
    print("Masukkan kategori transaksi yang ingin dihapus:");
    String kategori = stdin.readLineSync()?.trim() ?? '';
    if (kategori.isEmpty) {
      print("Kategori tidak boleh kosong!");
      return;
    }

    print("Masukkan jumlah transaksi yang ingin dihapus:");
    double harga = double.parse(stdin.readLineSync()!);
    
    bool berhasilDihapus = list.remove(kategori, harga);
    
    if (berhasilDihapus) {
      print("Transaksi berhasil dihapus!");
    } else {
      print("Transaksi tidak ditemukan!");
    }
  } catch (e) {
    print("Input tidak valid: $e");
  }
}

void printSemua(LinkedList list) {
  print("\nDaftar Semua Transaksi:");
  list.printList();
}

void printByKategori(LinkedList list) {
  try {
    print("Masukkan kategori yang ingin dicetak:");
    String kategori = stdin.readLineSync()?.trim() ?? '';
    if (kategori.isEmpty) {
      print("Kategori tidak boleh kosong!");
      return;
    }

    print("\nTransaksi dengan kategori '$kategori':");
    list.printByCategory(kategori);
  } catch (e) {
    print("Terjadi error: $e");
  }
}