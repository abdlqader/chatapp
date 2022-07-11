class MessageWorker
    include Sneakers::Worker
    from_queue $messageQueueName

    def work(msg)
        jsonMessage = JSON.parse(msg)
        Message.create(chat_id: jsonMessage['chat_id'],number: jsonMessage['message_number'],message: jsonMessage['message'])
        ack!
    end
end