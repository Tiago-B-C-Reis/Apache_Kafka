# Replace "kafka-console-producer.sh" 
# by "kafka-console-producer" or "kafka-console-producer.bat" based on your system # (or bin/kafka-console-producer.sh or bin\windows\kafka-console-producer.bat if you didn't setup PATH / Environment variables)

kafka-console-producer.sh 

############################
### CONDUKTOR PLATFORM #####
############################ 
security.protocol=SASL_SSL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="5TKRXQyrWoc6yb0W5qpsSP" password="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2F1dGguY29uZHVrdG9yLmlvIiwic291cmNlQXBwbGljYXRpb24iOiJhZG1pbiIsInVzZXJNYWlsIjpudWxsLCJwYXlsb2FkIjp7InZhbGlkRm9yVXNlcm5hbWUiOiI1VEtSWFF5cldvYzZ5YjBXNXFwc1NQIiwib3JnYW5pemF0aW9uSWQiOjcxMzQ4LCJ1c2VySWQiOjgyNjkzLCJmb3JFeHBpcmF0aW9uQ2hlY2siOiJiYzVhMGE2OC00OTc0LTQzM2UtOTU4Yy1jYjk4YzllNGM5MzgifX0.jczlhR_e5dD1ho327bU94LbP_GgHq6UnuT2eJURmVCQ";
sasl.mechanism=PLAIN

# producing
kafka-console-producer.sh --producer.config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic first_topic 
>Hello World
>My name is Conduktor
>I love Kafka
>^C  (<- Ctrl + C is used to exit the producer)


# producing with properties
kafka-console-producer.sh --producer.config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic first_topic --producer-property acks=all
> some message that is acked
> just for fun
> fun learning!


# producing to a non existing topic
kafka-console-producer.sh --producer.config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic new_topic
> hello world!

# if topic auto creation is disabled (by default on playground), then the topic will not appear in the list
kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --list

# overall, please create topics with the appropriate number of partitions before producing to them!


# produce with keys
kafka-console-producer.sh --producer.config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic first_topic --property parse.key=true --property key.separator=:
>example key:example value
>name:Stephane



############################
#####     LOCALHOST    #####
############################

kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --create --partitions 1

# producing
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic 
> Hello World
>My name is Conduktor
>I love Kafka
>^C  (<- Ctrl + C is used to exit the producer)


# producing with properties
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic --producer-property acks=all
> some message that is acked
> just for fun
> fun learning!


# producing to a non existing topic
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic new_topic
> hello world!

# our new topic only has 1 partition
kafka-topics.sh --bootstrap-server localhost:9092 --list
kafka-topics.sh --bootstrap-server localhost:9092 --topic new_topic --describe


# edit config/server.properties or config/kraft/server.properties
# num.partitions=3

# produce against a non existing topic again
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic new_topic_2
hello again!

# this time our topic has 3 partitions
kafka-topics.sh --bootstrap-server localhost:9092 --list
kafka-topics.sh --bootstrap-server localhost:9092 --topic new_topic_2 --describe

# overall, please create topics with the appropriate number of partitions before producing to them!


# produce with keys
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic --property parse.key=true --property key.separator=:
>example key:example value
>name:Stephane