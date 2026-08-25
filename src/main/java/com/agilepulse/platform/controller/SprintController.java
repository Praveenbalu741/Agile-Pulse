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
