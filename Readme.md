# Server Systems

* Physical Servers (BareMetal Servers):
    * Bilgisayar -> Yüksek donanım, özel işlemciler, özel işletim sistemleri.
    * Kurulum: zor
    * VeriTaşıma: zor
    * Maliyet: yüksek
    * Dedicated Servers
    * Barındırma -> Datecenter

* Virtual Servers (VMs: Virtual Machines):
    * Bir fiziksel makina içinde çok sanal makina.
    * Kurulum: orta (iso image)
    * VeriTaşıma: orta
    * Maliyet: orta
    * Bir makiaden diğer makinaya geçiş zorluğu.
    * Hypervisor yazılımları -> vmware.com
    * VPS (Virtual Private Server), VDS (Virtual Dedicated Server)

* Containers:
    * Bir fiziksel/sanal makina içinde çok konteyner.
    * Kurulum: kolay (docker image)
    * VeriTaşıma: kolay
    * Maliyet: düşük
    * Tüm konteynerları aynı ortamdan yönetebilme.
    * Microservice mimarisi.
    * Container yazılımları -> docker.com



///////////////////////////////////////////
///////////////////////////////////////////
///////////////////////////////////////////

- docker -> app imizi kendi env sinde çalıştırmamızı sağlıyordu, 
  - docker engine çalışıyor olması lazım
  - app imizin olması lazım container içerisinde
  - dockerfile
  - dockerfile ile image
  - image ile istediğimiz zaman bir container start edebilmemiz lazım.


- apps.py create edip basit bir script yazıyoruz.
- bunu dockerize edeceğiz.
- Önce dockerfile oluşturuyoruz. -> dockerfile
- belli başlı keywordler var bunlardan ilki FROM -> hangi image ı kullanacağım? 
- Buradaki image ları da docker hub dan kendimize uygun olanaları seçerek kullanacağız. https://hub.docker.com/  github gibi bir yer. public yayınlanmış image lar var, onları pull edebiliyorsunuz. Veya bir repo oluşturup, kendi image larınızı public veya private olarak push edebiliyorsunuz.
- Amazonun ECL diye bi,r servisi var, Github ında böyle bir servisi var bu container image ları pushlayacağınız. Burası image lar için dockerın kendi repository si diyebiliriz.
- hub.docker a gidip kendi oluşturacağımız image a temel olcak, kendimize uygun bir image seçiyoruz, biz python file çalışacağız, yani bizim imge ımızda içerisinde python olan bir işletim sistemi istiyoruz. Genelde linux tür işletim sistemleri. Ama içerisinde python olsun istiyoruz. python version da önemli ise python3.10, python3.11 versionu olan bir image olsun istiyoruz. FROM kısmı için bir image bulmamız gerekiyor, docker hub da python diye aratıyoruz, python docker official image dan -> tag altındaki -> versionlardan seçiyoruz. Biz şu anda alpine diye arattırıp daha küçük boyutlu birşey bakıyoruz. mesela alpine3.17 ye girip bir bakıyoruz, içerisinde ENV PYTHON_VERSION=3.11.1 olduğunu görüyoruz. Bu python3.11 bizim işimizi görür. Tabi buradan istediğimiz tag a sahip image ı seçebiliriz.
- image ların bir kendi isimleri oluyor bir de tag i oluyor. tag version u gösteriyor, asıl python image üzerine ekstra eklemeler yapılarak, farklı paketler yüklenerek, farklı versionlar yüklenerek ekstra tag koyarak çeşitlilik yapmışlar.
- Şuan bizim ekstra pakete ihtiyacımız yok, sadece python olsun, python3.11 işimizi görür, size olarak da küçük, bu image bizim işimizi görür, tag i alpine3.17, 
    - image ımızın ismi -> python,
    - tag i -> alpine3.17,
- bunu FROM olarak belirtiyoruz. Burdan kastımız; bir image oluştururken bize standart içerisinde python3.11 olan ve alpine linux olan bir tane docker oluşturmasını istiyoruz, onun da temelinin bu seçtiğimiz image olmasını istiyoruz.

- WORKDIR  -> container oluştuğu anda hangi directory de çalışacaksak orada bir folder oluşturuyor ve orada terminali ayağa kaldır. < WORKDIR /app ->  container ı ayağa kaldırdığında /app klasörü oluştur ve /app kalsöründe terminalini ayağa kaldır. >
- Eğer < WORKDIR /app -> yazmaz isek < COPY . . > yazamayız, < COPY . /app> şeklinde açık bir şekilde nereye yapıştıracağını açık bir şekilde belirtmemiz gerekir.

- Şimdi bunu üzerine birşeyler ekleyeceğiz, ne? kendi oluşturacağımız container içinde, oluşturduğumuz apps.py ın çalışmasını istiyoruz. Bunun için dockerfile da bunun için komut yazmamız gerekiyor, -> COPY komutu ile; bizim docker image ımızı çalıştırdığımızda localimizden file ları nereden alıp, nereye kopyaayacağını yazıyoruz. Nereden alacak? , nereye kopyalayacak? 
    - COPY .     ile dockerfile ın bulunduğu directory deki tüm herşeyi dahil et veya 
    - COPY apps.py index.html   şeklinde aralarında boşluk olarak file file da yazabiliriz,

    - Ardından copy ettiğimiz dosyaları nerede create edeceğimizi yazıyoruz, alpine linux işletim sistemine sahip bir container ayağa kaldıracağız ya işte bu containerda/serverda bu file ları nereye kaydedecek bunu yazmamızı istiyor, biz diyoruz ki yukarıda tanımladığımız /app folder ına kaydet diyoruz.< COPY . /app -> dockerfile ın bulunduğu directory deki tüm herşeyi al ve /app folder ına kaydet. > 
    - COPY apps.py /app  şeklinde de yazabilirdik.
    - COPY apps.py .  şeklinde de yazabilirdik. < apps.py ı bulunduğun klasöre kaydet yani /app içine >
    - COPY . .  şeklinde de yazabilirdik. < bulunduğun directory deki file ları al, git container daki o anda bulunduğun klasöre kaydet. Yani /app directory içerisine kaydet. >

- Bir de bu build işlemi bittikten sonra "RUN" ve "CMD" diye komutlar var.
  - RUN  -> build aşamasında yapılan komutları çalıştırır, mesela django app dockerize edeceksek build yaparken RUN "pip install -r requirements.txt" RUN komutunu kullanıyoruz.
  - CMD ise -> build bittikten sonra, container oluştu, file lar ve bütün klasörler oluştu, artık bundan sonra ne işlem yapmak istiyorsak CMD ile de bunu belirtiyoruz.
  - Bizim şu an RUN koymamıza gerek yok, conteiner ımızı içerinde file lar ile oluşturduk, artık CMD ile komut çalıştırabiliriz. Mesela < CMD python apps.py  ->  ile apps.py ı çalıştırabiliriz.>

```
FROM python:alpine3.17  # container ı şu image dan oluştur!
# COPY apps.py /app  # /app klasörü aç ve onu working directory yap! yani orada çalış!
# COPY apps.py .
COPY . .  # dockerfile ımızın yolu üzerindeki tüm file ları al, copy, nereye oluşturduğun  /app kalsörünün içerisine 
CMD python apps.py  # Yukarıdakileri yaptıktan sonra bu komutu çalıştır, sonucu ver!
```
- Yukarıdaki komutlar ile container ayağa kalktığında bize "hello world!" demesi lazım.
 
dockerfile -> 
```dockerfile
FROM python:alpine3.17
WORKDIR /app
# COPY apps.py /app
# COPY apps.py .
COPY . .
CMD python apps.py
```

#### image create

- dockerfile dan hangi komutla image oluşturuyorduk? < "docker build ."  -> sona koyduğumuz nokta ile buradaki dockerfile'dan / docker_simple_app kalsöründeki  dockerfile'dan bana bir image build et! dedik. Ancak isim/tag vermedik. image ımız oluşuyor, yani kalıbımız oluşuyor.
- Bu image lara tag verebiliriz.

```powershell
- docker build . # bulunduğun directorydeki dockerfile dan image oluştur!
```

- Eğer dockerfile başka bir yerde ise, busefer "." yerine dockerfile ın yolunu yazmamız gerekir.
```powershell
- docker build ../folder/ # bir üstteki folder klasörü directorysindeki dockerfile dan image oluştur!
```

#### image list

- image/kalıp ımız oluştu.

```powershell
- docker images # oluşturduğumuz image ı görebiliyoruz.
- docker image ls # oluşturduğumuz image ı görebiliyoruz.
```

- oluşan image ımızda repository ismi yok, tag i yok sadece image id si var. Bu mantıklı değil.

```text
REPOSITORY               TAG       IMAGE ID       CREATED         SIZE
<none>                   <none>    bc138b3dc239   2 minutes ago   52.4MB
```

- image ımızdaki repository ismi FROM da belirttiğimiz python'a, tag ise alpine3.17 ' ye karşılık geliyor.

#### image remove

- Şimdi madem name ve tag i yok bu imag ın, o zaman biz bu image ı silip yenisini oluşturalım. tabi name ve tag olmadığı için IMAGE ID sinin ilk üç karakteri ile silebiliyoruz. (bc1)

```powershell
- docker image rm bc1  # image id si bu olanı remove et!
```


#### image create right way

- repository name (hello-world) ve tag (1) vererek create -> 

```powershell
- docker build -t hello-world:1 .  # name ve tag vererek create image
- docker images
```

```text
REPOSITORY               TAG       IMAGE ID       CREATED         SIZE
hello-world              1         035924bab7d2   8 seconds ago   52.4MB
```


#### image ile docker container create etmek

- < docker run hello-world:1 > repository name (hello-world) ve tag (1) vererek container create (birkaç tane aynı image dan farklı taglerde oluşturduğumuz container varsa name ve tag yazmamız iyi olur.) -> 
- container oluşup ve çalışmasını bekliyoruz;

```powershell
- docker run hello-world:1  # name ve tag vererek create container oluşturmak
```

```text
hello world
```
- evet "hello world" ifadesini terminalde görerek container ın oluşup çalıştığını gördük.


```powershell
- docker run -d --name hi hello-world:1  # container a isim vererek (hi), image name ve tag i ile create container
```


- < docker run henryfrstr/hello-world:v1> böyle uzun yazmaktansa image id farklı is ilk 3 karakteri ile de container oluşturulup çalıştırılabilir, uzun uznu isim yazmaya gerek yok. Ancak aynı image id ile oluşmuş image lar var ise specific olarak name ve tag leri yazmak gerekiyor.


#### çalışan containerları görmek için ->

```powershell
- docker ps  # çalışan containerları görmek için
- docker ps -a  # çalışan/çalışmayan tüm containerları görmek için
```

- Bizim container imiz şu an çalışmıyor, neden? çünkü işlemini yaptı ve print('hello world') dedi ve bitti, bu kadar.


#### container içerisine run ederken bağlanmak için ->

- Oluşturdunuz container bir server, linux server ı ve bu linux server ın terminaline bağlanıp içerisinde işlemler yapılabilir.

- container a bağlanıp içerisindeki file lara bakabiliriz. Bunun için interaktif modda çalıştırmak gerekiyor.

- linux lerde bash terminale oluyor, < docker run -it merhaba:v1 > böyle çalıştırılırsa default olarak bash terminaldir.

-bash terminalden başka açacaksanız ki (alpine a özel birşey, alpine larda normal shell var, ubuntu kullansaydınız bna gerek yoktu.) kodun sonuna sh yazıyorsunuz  < docker run -it merhaba:v1 sh > 

```powershell
- docker run -it merhaba:v1  # default bash terminalinde çalışır
```


```powershell
- docker run -it merhaba:v1 sh  # shell çalışır. exit ile çıkılır terminalden
- python apps.py  # 
- exit  # terminalden çıkılır.
```


```powershell
- docker run merhaba:v1
```
- merhaba:v1 imagından container ı oluştur, çalıştır



```powershell
- docker run -it merhaba:v1
```
- merhaba:v1 imagından container ı oluştur, bana bir terminal aç


```powershell
- docker run -it merhaba:v1 sh
```
- merhaba:v1 imagından container ı oluştur, bana bir shell terminal aç


#### image remove with rmi 

- image name ve tag name ile docker rmi ile image silebiliyoru, ancak container oluşturulmuşsa silmez. 
- Biz yine de silmek istersek, force -f kullanmamız gerekiyor. 
- Bu şekilde silersek sildiğimiz image dan create ettiğimiz container/containerlar durduruluyor.

```powershell
- docker rmi merhaba:v1  # image ı bu (merhaba:v1) olanı remove et! container oluşturulmuşsa silmez!
- docker rmi -f merhaba:v1  # container oluşturulmuşsa bile image remove et! Bu image dan oluşturulan container da durduruluyor.
```


#### container delete etmek

```powershell
- docker rm <container_name>|<container_id> # Delete stopped container.
- docker container prune # delete all stopped container
```


### docker hub da repository create edip oluşturduğumuz image ı paylaşmak

- docker hub da hello-world isminde bir repository create et,
- dockerfile dan bir image oluştur -> 
```powershell
- docker build -t hello-world:1 .
```
- docker images ile hello-world isminde ve 1 Tag i ile oluştuğunu gördük.
- repository adresi ile push ediyoruz;
```powershell
- docker push umitdeveloper/hello-world
```
- hata verdi, localde < An image does not exist locally with the tag: umitdeveloper/hello-world> bu tag e sahip bir image yok dedi. localdeki image ımızın tag ini repository deki gibi değiştirmemizi istedi push etmeden önce, değiştireceğiz.
- tag değişikliği -> < docker tag hello-world:1 umitdeveloper/hello-world > bunu buna çevir
- istersek tag de verebiiriz < docker tag hello-world:1 umitdeveloper/hello-world:v1 > bunu buna çevir, v1 tag i ver!
- < docker images> ile kontrol ettiğimizde aynı image id den farklı bir image (repository->umitdeveloper/hello-world   Tag->v1) oluşturduğunu gördük. 

- repository adresi ile push ediyoruz;
```powershell
- docker push umitdeveloper/hello-world:v1
```
- terminalde pushlandığını gördük, dockerhub da image ın oluştuğunu gördük.

- başkasının reposundaki image ı pull ediyoruz.
- dockerhub da henryfrstr diye aratınca henryfrstr/hello-world çıkıyor, Tags başlığının altındaki v1 image ını kopyalayıp, 
- < docker pull henryfrstr/hello-world:v1 > çalıştırıp pull ediyoruz.
- < docker images> ile görüyoruz,
- < docker run henryfrstr/hello-world:v1> ile container oluşturduk ve çalıştı.

