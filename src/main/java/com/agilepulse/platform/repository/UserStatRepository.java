package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.UserStat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserStatRepository extends JpaRepository<UserStat, Long> {
    Optional<UserStat> findByUsername(String username);
}
