package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.RetroItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RetroItemRepository extends JpaRepository<RetroItem, Long> {
}
