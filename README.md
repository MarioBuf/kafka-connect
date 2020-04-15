## Kafka-Connect

Kafka-Connect rappresenta una parte del mio lavoro di Tesi di Laurea Triennale presso l'università degli Studi di Bari Aldo Moro. La presente repository contiene un progetto che estende Apache Kafka, con la possibilità di avviare un server in remoto senza dover configurare alcun IP statico, tramite la creazione di una immagine Docker.

### Technologies
* Ngrok
* Spring Framework
* Java 
* Apache Kafka
* Docker

### Setup Immagine Docker

Se avete la possibilità di configurare un IP statico per la vostra configurazione di rete, potete andare alla sezione 'Setup Diretto Apache Kafka'.
Per poter avviare correttamente il server tramite l'immagine Docker in un apposito container, seguite i seguenti passi:
1. Download e installazione dell'ultima versione di [Docker](https://www.docker.com/products/docker-desktop)
2. Aprite il prompt dei comandi ( o terminale, a seconda del vostro OS )
3. Eseguite il seguente comando per scaricare l'immagine: 
```
   docker pull marbuf/kafka-connect
```
4. Avviate l'immagine tramite il comando:
```
  docker run -eNGROK_AUTH=... -eHOSTNAME=... -eREGION=... marbuf/kafka-connect
```
  Al posto dei puntini, dovete sostituire rispettivamente: l'autorizzazione del vostro account Ngrok, l'hostname personalizzato associato al vostro account e la regione associata all'hostname personalizzato.


### Setup Diretto Apache Kafka

Per poter configurare una connessione diretta con un server Apache Kafka standalone, seguite i seguenti passi:
1. Donwload dell'ultima versione di [Apache Kafka](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.4.1/kafka_2.12-2.4.1.tgz)
2. Estraete il contenuto
3. Aprite il prompt dei comandi ( o terminale, a seconda del vostro OS )
4. Spostatevi nella cartella estratta con :
```
  cd path/cartella/estratta
```
5. Avviate Zookeeper, che serve come appoggio al server di Apache Kafka, con il seguente comando:
  Windows:
```
  bin\windows\zookeeper-server-start.bat config\zookeeper.properties
```
  Linux:
```
  bin\zookeeper-server-start.sh config\zookeeper.properties
```
6. Andate nella cartella /config . Modificate il file denonimanto _server.properties_, portando fuori dal commento e modificando la voce
```
  listeners=PLAINTEXT://:9092_
```
  in
```
  listeners=PLAINTEXT://ip_statico:porta
```
7. Aprite un secondo prompt dei comandi ( o terminale )
8. Ripetere passo 4
9. Avviate un server Apache Kafka con il seguente comando:
  Windows:
```
  bin\windows\kafka-server-start.bat config\server.properties
```
  Linux:
```
  bin\kafka-server-start.sh config\server.properties
```
10. Create un nuovo topic, dal nome _status_ ripetendo il passo 7 e 8 ed eseguendo il seguente comando
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
