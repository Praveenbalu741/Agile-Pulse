$baseDir = "c:/Users/prave/Downloads/Agile Pulse/src/main/java/com/agilepulse/platform"

# Repositories
$repoDir = "$baseDir/repository"
New-Item -ItemType Directory -Force -Path $repoDir | Out-Null

$standupRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.Standup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StandupRepository extends JpaRepository<Standup, Long> {
}
"@
Set-Content -Path "$repoDir/StandupRepository.java" -Value $standupRepo

$sprintRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.Sprint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SprintRepository extends JpaRepository<Sprint, Long> {
}
"@
Set-Content -Path "$repoDir/SprintRepository.java" -Value $sprintRepo

$kudoRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.Kudo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KudoRepository extends JpaRepository<Kudo, Long> {
}
"@
Set-Content -Path "$repoDir/KudoRepository.java" -Value $kudoRepo

$caseStudyRepo = @"
package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.CaseStudy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CaseStudyRepository extends JpaRepository<CaseStudy, Long> {
}
"@
Set-Content -Path "$repoDir/CaseStudyRepository.java" -Value $caseStudyRepo

# Services
$serviceDir = "$baseDir/service"
New-Item -ItemType Directory -Force -Path $serviceDir | Out-Null

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

    public List<Standup> getAllStandups() {
        return repository.findAll();
    }

    public Standup createStandup(Standup standup) {
        return repository.save(standup);
    }

    public Standup updateStandupStatus(Long id, String status) {
        Standup standup = repository.findById(id).orElseThrow();
        standup.setStatus(status);
        return repository.save(standup);
    }
}
"@
Set-Content -Path "$serviceDir/StandupService.java" -Value $standupService

$sprintService = @"
package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.Sprint;
import com.agilepulse.platform.repository.SprintRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SprintService {
    private final SprintRepository repository;

    public List<Sprint> getAllSprints() {
        return repository.findAll();
    }
}
"@
Set-Content -Path "$serviceDir/SprintService.java" -Value $sprintService

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

    public List<Kudo> getAllKudos() {
        return repository.findAll();
    }
    
    public Kudo createKudo(Kudo kudo) {
        return repository.save(kudo);
    }
}
"@
Set-Content -Path "$serviceDir/KudoService.java" -Value $kudoService

$caseStudyService = @"
package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.CaseStudy;
import com.agilepulse.platform.repository.CaseStudyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CaseStudyService {
    private final CaseStudyRepository repository;

    public List<CaseStudy> getAllCaseStudies() {
        return repository.findAll();
    }
}
"@
Set-Content -Path "$serviceDir/CaseStudyService.java" -Value $caseStudyService

# Controllers
$controllerDir = "$baseDir/controller"
New-Item -ItemType Directory -Force -Path $controllerDir | Out-Null

$standupController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.Standup;
import com.agilepulse.platform.service.StandupService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/standups")
@RequiredArgsConstructor
public class StandupController {
    private final StandupService service;

    @GetMapping
    public List<Standup> getAll() {
        return service.getAllStandups();
    }

    @PostMapping
    public Standup create(@RequestBody Standup standup) {
        return service.createStandup(standup);
    }

    @PatchMapping("/{id}/status")
    public Standup updateStatus(@PathVariable Long id, @RequestBody java.util.Map<String, String> payload) {
        return service.updateStandupStatus(id, payload.get("status"));
    }
}
"@
Set-Content -Path "$controllerDir/StandupController.java" -Value $standupController

$sprintController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.Sprint;
import com.agilepulse.platform.service.SprintService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/sprints")
@RequiredArgsConstructor
public class SprintController {
    private final SprintService service;

    @GetMapping
    public List<Sprint> getAll() {
        return service.getAllSprints();
    }
}
"@
Set-Content -Path "$controllerDir/SprintController.java" -Value $sprintController

$kudoController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.Kudo;
import com.agilepulse.platform.service.KudoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/kudos")
@RequiredArgsConstructor
public class KudosController {
    private final KudoService service;

    @GetMapping
    public List<Kudo> getAll() {
        return service.getAllKudos();
    }
    
    @PostMapping
    public Kudo create(@RequestBody Kudo kudo) {
        return service.createKudo(kudo);
    }
}
"@
Set-Content -Path "$controllerDir/KudosController.java" -Value $kudoController

$caseStudyController = @"
package com.agilepulse.platform.controller;

import com.agilepulse.platform.entity.CaseStudy;
import com.agilepulse.platform.service.CaseStudyService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/casestudy")
@RequiredArgsConstructor
public class CaseStudyController {
    private final CaseStudyService service;

    @GetMapping
    public List<CaseStudy> getAll() {
        return service.getAllCaseStudies();
    }
}
"@
Set-Content -Path "$controllerDir/CaseStudyController.java" -Value $caseStudyController

# Config (DataSeeder and Security)
$configDir = "$baseDir/config"
New-Item -ItemType Directory -Force -Path $configDir | Out-Null

$securityConfig = @"
package com.agilepulse.platform.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()
            )
            .headers(headers -> headers.frameOptions(frame -> frame.disable())); // for H2 console
        return http.build();
    }
}
"@
Set-Content -Path "$configDir/SecurityConfig.java" -Value $securityConfig

$dataSeeder = @"
package com.agilepulse.platform.config;

import com.agilepulse.platform.entity.*;
import com.agilepulse.platform.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

    private final StandupRepository standupRepository;
    private final SprintRepository sprintRepository;
    private final KudoRepository kudoRepository;
    private final CaseStudyRepository caseStudyRepository;

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
                    .build());
                    
            standupRepository.save(Standup.builder()
                    .teamMember("Bob")
                    .yesterday("Fixed CSS bugs")
                    .today("Implementing drag and drop")
                    .blockers("Need API endpoint")
                    .status("IN_PROGRESS")
                    .date(LocalDate.now())
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
    }
}
"@
Set-Content -Path "$configDir/DataSeeder.java" -Value $dataSeeder
