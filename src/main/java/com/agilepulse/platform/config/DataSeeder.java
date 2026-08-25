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
