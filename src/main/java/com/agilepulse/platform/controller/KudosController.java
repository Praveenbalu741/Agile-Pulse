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
