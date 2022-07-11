# Instabug Backend challenge - Jul 2022
## Disclaimer
My Experience in RoR doesn't exceed beyond this task, I gave my all in order to do this task as cleanly as possible.
## Design as Implemented
The project is splited into 3 main parts

1. application part which include application Creation, fetching and updating.
2. chat part which include chat creation and fetching plus handling the chat number.
3. message part which include message creation and fetching plus searching for specific string.

Regarding the update of `chats_count` and `messages_count`, I will use a job scheduler that runs every 30 mins to update the count for each Application and Chat that I have in my database.

## Run Command
`docker-compose up --build`

## endpoint tests
in order to test endpoints individually please use `Instabug Collection.postman_collection.json` collection

## Next steps and concerns
1. Write specs for the code
2. understand race condition and investigate if RabbitMq doesnt handle it properly
3. `chats_count` and `messages_count` handling should be inside the queue worker, but this might be Read/write consuming while its not required to be realtime
4. understand golang and see if it could be implemented in time
 