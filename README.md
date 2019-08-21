# pubsub-emulator
## gcloud publisher &amp; subscriber emulator

#### Requirements
* [docker](https://docs.docker.com/install) installed
* [docker-compose](https://docs.docker.com/compose) installed

#### Get start

1. Change *PROJECT_ID_EXAMPLE* variable with your project ID on `docker-compose.yml` file.
2. Run emulator.
```sh
$ docker-compose up
```

#### Usage
##### - Create publisher topic
```sh
$ ./publisher create [TOPIC_ID]
```
##### - Create topic subscriber/subscriber-push
```sh
$ ./subscriber create [TOPIC_ID] [SUBSCRIPTION_ID]
$ ./subscriber create-push [TOPIC_ID] [SUBSCRIPTION_ID] [ENDPOINT]
```
##### - Publishe message to the topic
```sh
$ curl -d '{"messages": [{"data": "msg_data"}]}' -H "Content-Type: application/json" -X POST 0.0.0.0:8085/v1/projects/[PUBSUB_PROJECT_ID]/topics/[TOPIC_ID]:publish
```
##### - Read subscriber messages
```sh
$ curl -d '{"returnImmediately": true, "maxMessages": 10}' -H "Content-Type: application/json" -X POST 0.0.0.0:8085/v1/projects/[PUBSUB_PROJECT_ID]/subscriptions/[SUBSCRIPTION_ID]:pull
```
##### - Publisher help
```sh
$ ./publisher -h
```
##### - Subscriber help
```sh
$ ./subscriber -h
```

#### More info
https://cloud.google.com/pubsub/docs/emulator