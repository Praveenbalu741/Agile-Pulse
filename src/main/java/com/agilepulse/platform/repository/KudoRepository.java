package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.Kudo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KudoRepository extends JpaRepository<Kudo, Long> {
}
