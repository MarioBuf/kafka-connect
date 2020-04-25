package kafka_connect.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;


@Service
public class ReceiverService {

    private final Logger LOG = LoggerFactory.getLogger(ReceiverService.class);
    
    private List<String> listMessages=new ArrayList<String>();

    @KafkaListener(topics = "status")
    private synchronized void consumeKafkaQueue(@Payload String message) {
    	LOG.info("Received message from kafka queue: {}", message);
    	listMessages.add(message);
    }
    
    public List<String> getAllMessages() {
    	return listMessages;
    }
}