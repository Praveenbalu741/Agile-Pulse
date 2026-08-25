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
    private final GamificationService gamificationService;
    private final NotificationService notificationService;

    public List<Kudo> getAllKudos() {
        return repository.findAll();
    }
    
    public Kudo createKudo(Kudo kudo) {
        gamificationService.awardXp(kudo.getReceiver(), 50); // 50 XP for receiving kudos
        notificationService.dispatchWebhook("KUDOS_AWARDED", kudo.getSender() + " sent kudos to " + kudo.getReceiver());
        return repository.save(kudo);
    }
}
