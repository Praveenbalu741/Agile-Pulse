package com.agilepulse.platform.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class NotificationService {
    
    public void dispatchWebhook(String eventType, String payload) {
        // Simulating a webhook call to an external service like Slack/Teams
        log.info(">>> [WEBHOOK DISPATCHED] Event: {}, Payload: {}", eventType, payload);
    }
}
