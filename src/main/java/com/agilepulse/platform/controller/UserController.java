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
