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
