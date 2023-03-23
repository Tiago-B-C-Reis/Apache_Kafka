# Replace "kafka-topics.sh" 
# by "kafka-topics" or "kafka-topics.bat" based on your system # (or bin/kafka-topics.sh or bin\windows\kafka-topics.bat if you didn't setup PATH / Environment variables)


############################
### CONDUKTOR PLATFORM #####
############################ 

# Create your playground.config file
# with content such as 
security.protocol=SASL_SSL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="5TKRXQyrWoc6yb0W5qpsSP" password="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2F1dGguY29uZHVrdG9yLmlvIiwic291cmNlQXBwbGljYXRpb24iOiJhZG1pbiIsInVzZXJNYWlsIjpudWxsLCJwYXlsb2FkIjp7InZhbGlkRm9yVXNlcm5hbWUiOiI1VEtSWFF5cldvYzZ5YjBXNXFwc1NQIiwib3JnYW5pemF0aW9uSWQiOjcxMzQ4LCJ1c2VySWQiOjgyNjkzLCJmb3JFeHBpcmF0aW9uQ2hlY2siOiJiYzVhMGE2OC00OTc0LTQzM2UtOTU4Yy1jYjk4YzllNGM5MzgifX0.jczlhR_e5dD1ho327bU94LbP_GgHq6UnuT2eJURmVCQ";
sasl.mechanism=PLAIN

# Start running commands
kafka-topics.sh 

kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092

kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --create --topic first_topic

kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --create --topic second_topic --partitions 5

# this will create a topic with an RF of 3 (behaviour of using Conduktor Platform - all topics have the same RF of 3)
kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --create --topic third_topic --replication-factor 2

# list topics
kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --list

# describe topics
kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic first_topic --describe

# delete topics
kafka-topics.sh --command-config playground.config --bootstrap-server cluster.playground.cdkt.io:9092 --topic second_topic --delete



############################
#####     LOCALHOST    #####
############################

kafka-topics.sh 

kafka-topics.sh --bootstrap-server localhost:9092 --list 

kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --create

kafka-topics.sh --bootstrap-server localhost:9092 --topic second_topic --create --partitions 3

kafka-topics.sh --bootstrap-server localhost:9092 --topic third_topic --create --partitions 3 --replication-factor 2

# Create a topic (working)
kafka-topics.sh --bootstrap-server localhost:9092 --topic third_topic --create --partitions 3 --replication-factor 1

# List topics
kafka-topics.sh --bootstrap-server localhost:9092 --list 

# Describe a topic
kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --describe

# Delete a topic 
kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --delete
# (only works if delete.topic.enable=true)
