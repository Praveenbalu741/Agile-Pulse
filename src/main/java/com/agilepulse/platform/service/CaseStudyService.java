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
