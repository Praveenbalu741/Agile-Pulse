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
