package io.conduktor.demos.kafka;

import org.apache.kafka.clients.producer.*;
import org.apache.kafka.common.serialization.StringSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;


public class ProducerDemoWithCallback {

    private static final Logger log = LoggerFactory.getLogger(ProducerDemoWithCallback.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I'm a Kafka Producer!");

        // create Producer Properties
        Properties properties = new Properties();

        // connect to Localhost
        // properties.setProperty("bootstrap.servers", "127.9.9.1:9092");

        // connect to Conduktor Playground
        properties.setProperty("bootstrap.servers", "cluster.playground.cdkt.io:9092");
        properties.setProperty("security.protocol", "SASL_SSL");
        properties.setProperty("sasl.jaas.config", "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"5TKRXQyrWoc6yb0W5qpsSP\" password=\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2F1dGguY29uZHVrdG9yLmlvIiwic291cmNlQXBwbGljYXRpb24iOiJhZG1pbiIsInVzZXJNYWlsIjpudWxsLCJwYXlsb2FkIjp7InZhbGlkRm9yVXNlcm5hbWUiOiI1VEtSWFF5cldvYzZ5YjBXNXFwc1NQIiwib3JnYW5pemF0aW9uSWQiOjcxMzQ4LCJ1c2VySWQiOjgyNjkzLCJmb3JFeHBpcmF0aW9uQ2hlY2siOiJiYzVhMGE2OC00OTc0LTQzM2UtOTU4Yy1jYjk4YzllNGM5MzgifX0.jczlhR_e5dD1ho327bU94LbP_GgHq6UnuT2eJURmVCQ\";");
        properties.setProperty("sasl.mechanism", "PLAIN");

        // set producer properties
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());

        properties.setProperty("batch.size", "400");

        // properties.setProperty("partitioner.class", RoundRobinPartitioner.class.getName());


        // create the Producer
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);


        for (int j=0; j<10; j++){

            for (int i=0; i<30; i++){

                // create a Producer Record
                ProducerRecord<String, String> producerRecord =
                        new ProducerRecord<>("demo_java", "hello world" + i);

                // send data
                producer.send(producerRecord, new Callback() {
                    @Override
                    public void onCompletion(RecordMetadata metadata, Exception e) {
                        // executes every time a record successfully sent or an exception is thrown
                        if (e == null) {
                            // the record was successfully sent
                            log.info("Received new metadata \n" +
                                    "Topic: " + metadata.topic() + "\n" +
                                    "Partition: " + metadata.partition() + "\n" +
                                    "Offset: " + metadata.offset() + "\n" +
                                    "Timestamp: " + metadata.timestamp());
                        } else {
                            log.error("Error while production", e);
                        }
                    }
                });
            }

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        // tel the producer to send all data and block until done -- synchronous
            producer.flush();

            // flush and close the producer
            producer.close();
    }
}
