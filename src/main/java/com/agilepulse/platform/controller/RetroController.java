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
