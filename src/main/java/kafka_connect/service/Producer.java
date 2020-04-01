package kafka_connect.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Properties;

import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class Producer {
	private static final Logger log=LoggerFactory.getLogger(Producer.class.getName());
	
	public void sendMessage(String message) {
		Properties config = new Properties();
		try {
			config.put("client.id", InetAddress.getLocalHost().getHostName());
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		config.put("bootstrap.servers", "localhost:9092");
		config.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		config.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		config.put("acks", "all");
		KafkaProducer<String, String> producer=new KafkaProducer<String, String>(config);
		final ProducerRecord<String, String> record = new ProducerRecord<>("status", message);
		producer.send(record, new Callback() {
		  public void onCompletion(RecordMetadata metadata, Exception e) {
		    if (e != null)
		      log.debug("Send failed for record {}", record, e);
		  }
		});
		producer.close();
	}
}
