package com.agilepulse.platform.service;

import com.agilepulse.platform.entity.RetroItem;
import com.agilepulse.platform.repository.RetroItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RetroService {
    private final RetroItemRepository repository;

    public List<RetroItem> getAll() {
        return repository.findAll();
    }

    public RetroItem create(RetroItem item) {
        if(item.getVotes() == null) item.setVotes(0);
        return repository.save(item);
    }

    public RetroItem upvote(Long id) {
        RetroItem item = repository.findById(id).orElseThrow();
        item.setVotes(item.getVotes() + 1);
        return repository.save(item);
    }
}
