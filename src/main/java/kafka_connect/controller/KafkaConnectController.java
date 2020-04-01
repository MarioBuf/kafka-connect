package kafka_connect.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kafka_connect.service.Producer;
import kafka_connect.service.ReceiverService;

@RestController
@RequestMapping(value="/kafka")
public class KafkaConnectController {
	
	private final Producer producer=new Producer();
	
	@Autowired
	private ReceiverService consumer;
	
	@GetMapping(value = "/producer")
    public void sendMessageToKafkaTopic(@RequestParam("message") String message) {
        producer.sendMessage(message);
    }
	
	@GetMapping(value = "/consumer")
    public ResponseEntity<Map<String, String>> getMessages() {
		Map<String, String> lista=new HashMap<String, String>();
		for(String message: consumer.getAllMessages()) {
			String[] details=message.split("_:_");
			if(details[0].length()>0 && details[1].length()>0)
				lista.put(details[0], details[1]);
		}
		return new ResponseEntity<Map<String, String>>(lista, HttpStatus.OK);
    }
}
