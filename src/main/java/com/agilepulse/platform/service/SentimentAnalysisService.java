package com.agilepulse.platform.service;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SentimentAnalysisService {
    
    private final List<String> negativeKeywords = List.of("blocker", "stuck", "burnout", "overwhelmed", "failing", "blocked", "issue");

    public double analyzeSentiment(String text) {
        if (text == null || text.isBlank()) return 0.0;
        
        String lowerText = text.toLowerCase();
        int negativeHits = 0;
        for (String word : negativeKeywords) {
            if (lowerText.contains(word)) {
                negativeHits++;
            }
        }
        
        // Simple heuristic: map hits to a score between -1.0 and +1.0
        if (negativeHits == 0) return 0.8;
        if (negativeHits == 1) return -0.2;
        return -0.9;
    }
    
    public boolean isAtRisk(double sentimentScore) {
        return sentimentScore < -0.5;
    }
}
