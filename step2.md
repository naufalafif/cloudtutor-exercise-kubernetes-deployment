### Struktur

Kita mulai dari sebuah Pod. Berikut adalah konfigurasi YAML untuk Pod nginx

```{.yaml}
apiVersion: v1
kind: Pod
metadata:
  name: simple-web-pod
  labels:
    app: simple-web
spec:
  containers:
  - name: simple-web-container
    image: nginx
    ports:
    - containerPort: 80
```

Dalam contoh ini, kita membuat Pod dengan:

- Nama: simple-web-pod
- Label: app=simple-web
- Container: simple-web-container
- Image: nginx
- Port: 80

Sekarang, mari kita lihat Deployment yang mengelola replika aplikasi yang sama.

```{.yaml}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: simple-web-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: simple-web
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: simple-web
    spec:
      containers:
      - name: simple-web-container
        image: nginx
        ports:
        - containerPort: 80
```

Dalam contoh ini, kita membuat Deployment dengan:

- Nama: simple-web-deployment
- Replicas: 3 pod yang menjalankan aplikasi simple-web
- Selector: app=simple-web
- Strategy: Rolling
- Template pod nginx sebelumnya

Perhatikan stuktur dari Deployment diatas, terdapat 4 attribute baru yang digunakan oleh deployment yaitu `Replicas`, `Selector`, `Strategy`, `Template`.

#### Replicas

Replicas mengacu pada jumlah instance dari suatu aplikasi yang diinginkan untuk berjalan secara paralel, dengan setiap instance berjalan dalam sebuah Pod. Mengatur jumlah replicas memungkinkan penyesuaian skalabilitas aplikasi sesuai kebutuhan untuk menghandle lebih banyak user atau traffic yang lebih besar

#### Selector

Selector digunakan untuk menentukan pod mana yang akan dikendalikan oleh Deployment tersebut. Selector adalah serangkaian kriteria atau label yang harus cocok dengan metadata dari pod yang dikelola. Misal selector menentukan label yang harus digunakan adalah `app=nginx`, maka deployment akan mengatur pod dengan kriteria yang sama yaitu yang memiliki label dengan nilai `app=nginx`.

#### Template

Template adalah bagian dari konfigurasi yang mendefinisikan blueprint atau cetak biru dari pod yang akan dibuat oleh Deployment. Template pod mencakup semua konfigurasi yang diperlukan untuk membuat pod, seperti spesifikasi container, port yang digunakan, dan metadata seperti label.

#### Strategy

Deployment Strategy menggambarkan bagaimana Deployment akan melakukan pembaruan aplikasi dan menggantikan pod yang ada dengan pod baru yang memiliki konfigurasi yang diperbarui. Ada dua strategi utama yang dapat digunakan dalam Deployment: RollingUpdate dan Recreate.

- `RollingUpdate` adalah strategi default dan secara bertahap memperbarui pod dengan cara menggantikan satu per satu, memastikan tidak ada interupsi dalam ketersediaan aplikasi. Dalam strategi ini, Deployment akan membuat pod baru menggunakan konfigurasi yang diperbarui dan secara bertahap menghentikan pod lama seiring mendeploy pod baru. Hal ini memungkinkan deployment yang lancar tanpa downtime dan meminimalkan dampak pada pengguna.

- `Recreate`, dalam strategi ini, Deployment menghapus semua pod yang ada sebelum membuat pod baru dengan konfigurasi yang diperbarui. Ini menyebabkan downtime aplikasi selama proses pembaruan, tetapi berguna jika aplikasi tidak dapat menangani perubahan secara bertahap atau jika kita memerlukan semua pod untuk menggunakan konfigurasi baru secara bersamaan.
