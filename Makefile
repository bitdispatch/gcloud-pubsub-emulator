# 1. launch local docker pubsub server 
# 2. create topics & subcriptions
init:
	docker-compose up -d
	
	./publisher create post-fetched
	./subscriber create post-fetched post-fetched-sub
	
	./publisher create crawled-post
	./subscriber create crawled-post crawled-post-sub
	
	./publisher create post-image-processed
	./subscriber create post-image-processed new-processed-post


# Pull message from REST API -> parse all messages with jq -> decode message text -> back to JSON 
pull-post-fetched:
	http 0.0.0.0:8085/v1/projects/bitdispatch-local/subscriptions/post-fetched-sub:pull returnImmediately:=true maxMessages:=10 | jq -c '.receivedMessages[].message.data' | jq -r '@base64d'| jq -s

pull-crawled-posts:
	http 0.0.0.0:8085/v1/projects/bitdispatch-local/subscriptions/crawled-post-sub:pull returnImmediately:=true maxMessages:=10 | jq -c '.receivedMessages[].message.data' | jq -r '@base64d'| jq -s

# pull-post-image-processed:
# 	http 0.0.0.0:8085/v1/projects/bitdispatch-local/subscriptions/post-image-processed-sub:pull returnImmediately:=true maxMessages:=10 | jq -c '.receivedMessages[].message.data' | jq -r '@base64d'| jq -s

pull-new-processed-post:
	http 0.0.0.0:8085/v1/projects/bitdispatch-local/subscriptions/new-processed-post:pull returnImmediately:=true maxMessages:=10 | jq -c '.receivedMessages[].message.data' | jq -r '@base64d'| jq -s

