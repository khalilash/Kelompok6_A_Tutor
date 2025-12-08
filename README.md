# 📚 TUTOR – Aplikasi Pencarian & Pemesanan Tutor Belajar

TUTOR adalah aplikasi mobile berbasis **Flutter** yang dirancang untuk membantu mahasiswa menemukan tutor yang sesuai preferensi mereka, melihat jadwal, memesan sesi mentoring, dan berkomunikasi langsung melalui fitur chat. Aplikasi ini dibuat sebagai proyek mata kuliah **Teknologi Berkembang – A**.

---

## 👥 Anggota Kelompok 6

- Khalila Shafarayhani Atletiko – 5026231167  
- Nabila Rahadatul Aisy Koestriyaningrum – 5026231025  
- Alisha Rafimalia – 5026231202  
- Naura Salsabila – 5026231173  
- Jasmine Fathina Hakim – 50262331017  
- Sahilah Amru Yumnatusta – 5026231182  
- Mochammad Zhulmi Danovanz Hidanasukha – 5026231172  

---

## 📝 Deskripsi Singkat

Aplikasi **TUTOR** menyediakan tiga fitur utama:

1. **Pesan Sesi** – pengguna dapat memilih tutor, menentukan tanggal & jam, dan melakukan pemesanan sesi belajar.  
2. **Sesi Tutor** – menampilkan detail sesi, status sesi (belum dimulai, sedang berlangsung, selesai), serta akses ke video call dan materi.  
3. **Chat Tutor** – fitur chat untuk komunikasi antara mahasiswa dan tutor sebelum, saat, maupun setelah sesi.  

Saat ini aplikasi masih menggunakan **mock/local data** dan dapat dikembangkan lebih lanjut dengan backend (misalnya Supabase / REST API) untuk komunikasi real-time dan penyimpanan data sesungguhnya.

---

## 🧩 Teknologi yang Digunakan

- **Flutter** – framework utama pengembangan aplikasi mobile  
- **Dart** – bahasa pemrograman  
- **Figma** – perancangan UI/UX  
- **VS Code / Android Studio** – editor & emulator pengembangan  
- **Mock Data / Local Data** – simulasi data awal sebelum integrasi backend  

---

## 📦 Struktur Proyek

```text
lib/
 ├─ main.dart
 ├─ splash_page.dart
 └─ screens/
    ├─ booking/        # fitur pesan sesi
    ├─ chat/           # chat list & chat room
    ├─ homepage/       # home screen
    ├─ login-register/ # welcome, register, login
    ├─ search/         # fitur pencarian tutor
    ├─ sesi/           # detail sesi, calling, video call, review
    └─ widgets/        # bottom navbar, popup, dll
assets/
 ├─ images/            # ikon, foto tutor, ilustrasi
 └─ fonts/             # font Poppins


## 🚀 Getting Started

```sh
# Clone repo
git clone https://github.com/khalilash/Kelompok6_Tutor_progress2.git 
cd Kelompok6_Tutor_progress2

# Install dependency
flutter pub get

# Run di Android / emulator
flutter run

# (Opsional) Run di browser
flutter run -d chrome

### Splash & Welcome
![Splash](assets/screenshots/splash.png)
![Welcome](assets/screenshots/welcome.png)

### Home & Booking
![Home](assets/screenshots/home.png)
![Booking](assets/screenshots/booking.png)

### Sesi Tutor & Chat
![Sesi Tutor](assets/screenshots/sesi.png)
![Chat](assets/screenshots/chat.png)
 
