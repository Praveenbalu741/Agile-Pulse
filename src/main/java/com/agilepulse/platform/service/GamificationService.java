package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.UserStat;
import com.agilepulse.platform.repository.UserStatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GamificationService {
    
    private final UserStatRepository repository;
    private final NotificationService notificationService;

    public void awardXp(String username, int amount) {
        UserStat stat = repository.findByUsername(username).orElseGet(() -> 
            UserStat.builder().username(username).xp(0).level(1).currentStreak(0).build()
        );
        
        stat.setXp(stat.getXp() + amount);
        
        // Level up logic (every 100 XP)
        int newLevel = (stat.getXp() / 100) + 1;
        if (newLevel > stat.getLevel()) {
            stat.setLevel(newLevel);
            notificationService.dispatchWebhook("LEVEL_UP", username + " reached Level " + newLevel + "!");
            
            if (newLevel == 2 && !stat.getUnlockedBadges().contains("Standup Hero")) {
                stat.getUnlockedBadges().add("Standup Hero");
            }
        }
        
        repository.save(stat);
    }
}
