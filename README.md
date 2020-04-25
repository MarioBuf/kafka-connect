## Kafka-Connect

Kafka-Connect è un progetto che estende Apache Kafka, con la possibilità di avviare un server in remoto senza dover configurare alcun IP statico, tramite la creazione di una immagine Docker.

### Technologies
* Ngrok
* Spring Framework
* Java 
* Apache Kafka
* Docker

## Setup

Se avete la possibilità di configurare un IP statico per la vostra configurazione di rete, potete andare alla sezione 'Setup Diretto Apache Kafka'.

### Immagine Docker

#### Download

* [Docker](https://www.docker.com/products/docker-desktop)

#### Configuration

Step da seguire:
1. Cliccate con il tasto destro sull'icona di Docker in basso a destra e seleziona _Switch to Linux Containers_.
2. Eseguite il seguente comando per scaricare l'immagine buildata:
```
   docker pull marbuf/kafka-connect
```

#### Deployment

Per avviare l'immagine scaricata, usate il comando:
```
  docker run -eNGROK_AUTH=... -eHOSTNAME=... -eREGION=... marbuf/kafka-connect
```
Al posto dei puntini, dovete sostituire rispettivamente: l'autorizzazione del vostro account Ngrok, l'hostname personalizzato associato al vostro account e la regione associata all'hostname personalizzato.

### Setup Diretto Apache Kafka

#### Download

Scaricate l'ultima versione di Apache Kafka:
[Apache Kafka](https://kafka.apache.org/downloads)
In seguito, estraete il contenuto.

#### Configuration

Nella cartella estratta, modificate il file _server.properties_ presente nella cartella _/config_, aggiungendo la seguente linea di codice:
```
listeners=PLAINTEXT://indirizzo_ip:porta
```
Sostituite indirizzo_ip con quello statico e aggiungendo la porta aperta (di default dovrebbe essere 9092) al quale il server di Apache Kafka rimarrà in ascolto.

#### Run

1. Tramite terminale, spostatevi nella cartella estratta con :
```
  cd path/cartella/estratta
```
2. Avviate Zookeeper, che serve come appoggio al server di Apache Kafka, con il seguente comando:

  Windows:
```
  bin\windows\zookeeper-server-start.bat config\zookeeper.properties
```
  Linux:
```
  bin\zookeeper-server-start.sh config\zookeeper.properties
```
3. Aprite un secondo prompt dei comandi ( o terminale )
4. Avviate un server Apache Kafka con il seguente comando:

  Windows:
```
  bin\windows\kafka-server-start.bat config\server.properties
```
  Linux:
```
  bin\kafka-server-start.sh config\server.properties
```
5. Aprite un ulteriore terminale
10. Create un nuovo topic, dal nome _status_ :
  Windows:
```
  bin\windows\kafka-topics.bat --create --bootstrap-server IP-STATICO:PORTA --replication-factor 1 --partitions 1 --topic status
```
  Linux:
```
  bin\kafka-topics.sh --create --bootstrap-server IP-STATICO:PORTA --replication-factor 1 --partitions 1 --topic status
```

### Collegamento tra il Plugin realizzato e il server

Una volta completato questi passi, il server sarà avviato in un container docker. E' possibile connettere il plugin presente nella repository del [progetto principale](https://github.com/collab-uniba/Group-Awareness-Plugin-for-Unity), inserendo nell'apposita sezione l'hostname/indirizzo IP inserito come parametro di avvio.

## Resources & Libraries

* [Docker](https://www.docker.com/products/docker-desktop)
* [Java](https://www.java.com/it/download/)

## Authors

* **[Mario Buffelli](www.github.com/MarioBuf)**
