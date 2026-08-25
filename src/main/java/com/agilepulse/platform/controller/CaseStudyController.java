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
