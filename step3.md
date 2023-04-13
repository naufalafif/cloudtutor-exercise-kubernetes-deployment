#### Membuat Deployment

Dalam contoh ini, kita akan membuat Deployment untuk aplikasi web sederhana yang menggunakan image nginx.

Buat file konfigurasi YAML dengan nama `nginx-deployment.yaml` dan isi dengan kode berikut:

```{.yaml .copy}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

Dalam contoh ini, kita membuat Deployment dengan:

- Nama: nginx-deployment
- Replika: 3 pod yang menjalankan aplikasi nginx
- Image: nginx versi 1.14.2
- Port: container menjalankan nginx pada port 80

Simpan file dan jalankan perintah berikut untuk membuat Deployment:

```{.bash .copy}
kubectl create -f nginx-deployment.yaml
```

Untuk melihat Deployment yang telah dibuat, jalankan perintah:

```{.bash .copy}
kubectl get deployments
```

Kita akan melihat output seperti berikut:

```{.bash}
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           1m
```

Ini menunjukkan bahwa Deployment berhasil dibuat dengan 3 replika yang diharapkan dan semua pod dalam keadaan siap (Ready).

Kita juga dapat melihat informasi lebih detail tentang Deployment dengan menjalankan perintah:

```{.bash .copy}
kubectl describe deployment nginx-deployment
```

Jika ingin melihat pod yang dibuat oleh Deployment, jalankan perintah berikut:

```{.bash .copy}
kubectl get pods -l app=nginx
```

Output akan menunjukkan pod yang dibuat oleh Deployment, seperti:

```{.bash}
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5c689d88bb-4kgx4   1/1     Running   0          1m
nginx-deployment-5c689d88bb-d8c5v   1/1     Running   0          1m
nginx-deployment-5c689d88bb-zg7z8   1/1     Running   0          1m
```

Dalam contoh ini, kita telah membuat Deployment untuk aplikasi web sederhana menggunakan nginx.

#### Menghapus Deployment

Untuk menghapus Deployment yang telah dibuat, jalankan perintah berikut

```{.bash .copy}
kubectl delete deployment nginx-deployment
```
