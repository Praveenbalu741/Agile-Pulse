package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.Standup;
import com.agilepulse.platform.repository.StandupRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StandupService {
    private final StandupRepository repository;
    private final SentimentAnalysisService sentimentService;
    private final GamificationService gamificationService;
    private final NotificationService notificationService;

    public List<Standup> getAllStandups() {
        return repository.findAll();
    }

    public Standup createStandup(Standup standup) {
        // AI Sentiment Analysis
        String combinedText = standup.getYesterday() + " " + standup.getToday() + " " + standup.getBlockers();
        double score = sentimentService.analyzeSentiment(combinedText);
        standup.setSentimentScore(score);
        
        boolean atRisk = sentimentService.isAtRisk(score);
        standup.setIsAtRisk(atRisk);
        
        if(atRisk) {
            notificationService.dispatchWebhook("BURNOUT_RISK", standup.getTeamMember() + " is flagged at risk based on standup notes.");
        }

        // Gamification
        gamificationService.awardXp(standup.getTeamMember(), 20); // 20 XP for standup

        return repository.save(standup);
    }

    public Standup updateStandupStatus(Long id, String status) {
        Standup standup = repository.findById(id).orElseThrow();
        standup.setStatus(status);
        return repository.save(standup);
    }
}
