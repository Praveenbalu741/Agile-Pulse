$baseDir = "c:/Users/prave/Downloads/Agile Pulse/src/main/java/com/agilepulse/platform"

# 1. Update Standup Entity
$standupEntity = @"
package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Entity
@Table(name = "standups")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Standup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String teamMember;
    private String yesterday;
    private String today;
    private String blockers;
    private String status; // TO_DO, IN_PROGRESS, REVIEW, DONE
    
    private LocalDate date;

    // AI Sentiment Features
    private Double sentimentScore;
    private Boolean isAtRisk;
}
"@
Set-Content -Path "$baseDir/entity/Standup.java" -Value $standupEntity

# 2. New Entities (RetroItem, UserStat, Badge)
$retroEntity = @"
package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "retro_items")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RetroItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String type; // START, STOP, CONTINUE
    private String content;
    private Integer votes;
}
"@
Set-Content -Path "$baseDir/entity/RetroItem.java" -Value $retroEntity

$userStatEntity = @"
package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user_stats")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserStat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private Integer xp;
    private Integer level;
    private Integer currentStreak;

    @ElementCollection(fetch = FetchType.EAGER)
    @Builder.Default
    private List<String> unlockedBadges = new ArrayList<>();
}
"@
Set-Content -Path "$baseDir/entity/UserStat.java" -Value $userStatEntity

# 3. New Repositories
$retroRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.RetroItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RetroItemRepository extends JpaRepository<RetroItem, Long> {
}
"@
Set-Content -Path "$baseDir/repository/RetroItemRepository.java" -Value $retroRepo

$userStatRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.UserStat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserStatRepository extends JpaRepository<UserStat, Long> {
    Optional<UserStat> findByUsername(String username);
}
"@
Set-Content -Path "$baseDir/repository/UserStatRepository.java" -Value $userStatRepo

# 4. New Services
$notificationService = @"
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
"@
Set-Content -Path "$baseDir/service/NotificationService.java" -Value $notificationService

$sentimentService = @"
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
"@
Set-Content -Path "$baseDir/service/SentimentAnalysisService.java" -Value $sentimentService

$gamificationService = @"
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
"@
Set-Content -Path "$baseDir/service/GamificationService.java" -Value $gamificationService

$retroService = @"
package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.RetroItem;
import com.agilepulse.platform.repository.RetroItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RetroService {
    private final RetroItemRepository repository;

    public List<RetroItem> getAll() {
        return repository.findAll();
    }

    public RetroItem create(RetroItem item) {
        if(item.getVotes() == null) item.setVotes(0);
        return repository.save(item);
    }

    public RetroItem upvote(Long id) {
        RetroItem item = repository.findById(id).orElseThrow();
        item.setVotes(item.getVotes() + 1);
        return repository.save(item);
    }
}
"@
Set-Content -Path "$baseDir/service/RetroService.java" -Value $retroService

# Update StandupService and KudoService to use new services
$standupService = @"
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
"@
Set-Content -Path "$baseDir/service/StandupService.java" -Value $standupService

$kudoService = @"
package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.Kudo;
import com.agilepulse.platform.repository.KudoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class KudoService {
    private final KudoRepository repository;
    private final GamificationService gamificationService;
    private final NotificationService notificationService;

    public List<Kudo> getAllKudos() {
        return repository.findAll();
    }
    
    public Kudo createKudo(Kudo kudo) {
        gamificationService.awardXp(kudo.getReceiver(), 50); // 50 XP for receiving kudos
        notificationService.dispatchWebhook("KUDOS_AWARDED", kudo.getSender() + " sent kudos to " + kudo.getReceiver());
        return repository.save(kudo);
    }
}
"@
Set-Content -Path "$baseDir/service/KudoService.java" -Value $kudoService

# 5. Controllers
$retroController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.RetroItem;
import com.agilepulse.platform.service.RetroService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/retro")
@RequiredArgsConstructor
public class RetroController {
    private final RetroService service;

    @GetMapping
    public List<RetroItem> getAll() {
        return service.getAll();
    }

    @PostMapping
    public RetroItem create(@RequestBody RetroItem item) {
        return service.create(item);
    }

    @PostMapping("/{id}/upvote")
    public RetroItem upvote(@PathVariable Long id) {
        return service.upvote(id);
    }
}
"@
Set-Content -Path "$baseDir/controller/RetroController.java" -Value $retroController

$userStatController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.UserStat;
import com.agilepulse.platform.repository.UserStatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserController {
    private final UserStatRepository repository;

    @GetMapping("/{username}/stats")
    public UserStat getStats(@PathVariable String username) {
        return repository.findByUsername(username).orElseGet(() -> 
            UserStat.builder().username(username).xp(0).level(1).currentStreak(0).build()
        );
    }
}
"@
Set-Content -Path "$baseDir/controller/UserController.java" -Value $userStatController

# 6. Update DataSeeder
$dataSeeder = @"
package com.agilepulse.platform.config;

import com.agilepulse.platform.entity.*;
import com.agilepulse.platform.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

    private final StandupRepository standupRepository;
    private final SprintRepository sprintRepository;
    private final KudoRepository kudoRepository;
    private final CaseStudyRepository caseStudyRepository;
    private final RetroItemRepository retroItemRepository;
    private final UserStatRepository userStatRepository;

    @Override
    public void run(String... args) throws Exception {
        if (standupRepository.count() == 0) {
            standupRepository.save(Standup.builder()
                    .teamMember("Alice")
                    .yesterday("Worked on auth API")
                    .today("Review PRs")
                    .blockers("None")
                    .status("TO_DO")
                    .date(LocalDate.now())
                    .sentimentScore(0.8)
                    .isAtRisk(false)
                    .build());
                    
            standupRepository.save(Standup.builder()
                    .teamMember("Bob")
                    .yesterday("Fixed CSS bugs")
                    .today("Implementing drag and drop")
                    .blockers("Stuck on a severe blocker, feeling burnout")
                    .status("IN_PROGRESS")
                    .date(LocalDate.now())
                    .sentimentScore(-0.9)
                    .isAtRisk(true)
                    .build());
        }

        if (sprintRepository.count() == 0) {
            sprintRepository.save(Sprint.builder()
                    .name("Sprint 42")
                    .velocity(85)
                    .completedPoints(34)
                    .totalPoints(40)
                    .teamMorale(8)
                    .build());
        }

        if (kudoRepository.count() == 0) {
            kudoRepository.save(Kudo.builder()
                    .sender("Alice")
                    .receiver("Bob")
                    .message("Great job on the CSS fixes!")
                    .build());
        }
        
        if (caseStudyRepository.count() == 0) {
            caseStudyRepository.save(CaseStudy.builder()
                    .title("Agile Pulse Design System")
                    .description("The design system uses a dark mode aesthetic with glowing glassmorphism gradients.")
                    .imageUrl("/assets/design.png")
                    .build());
        }

        if (retroItemRepository.count() == 0) {
            retroItemRepository.save(RetroItem.builder().type("START").content("More pair programming").votes(3).build());
            retroItemRepository.save(RetroItem.builder().type("STOP").content("Merging PRs without review").votes(5).build());
            retroItemRepository.save(RetroItem.builder().type("CONTINUE").content("Weekly tech talks").votes(8).build());
        }

        if (userStatRepository.count() == 0) {
            userStatRepository.save(UserStat.builder()
                    .username("Admin")
                    .xp(350)
                    .level(4)
                    .currentStreak(5)
                    .unlockedBadges(List.of("Standup Hero", "Bug Slayer"))
                    .build());
        }
    }
}
"@
Set-Content -Path "$baseDir/config/DataSeeder.java" -Value $dataSeeder
