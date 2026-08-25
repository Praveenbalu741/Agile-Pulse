package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.Standup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StandupRepository extends JpaRepository<Standup, Long> {
}
