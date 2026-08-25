package com.agilepulse.platform.repository;

import com.agilepulse.platform.entity.CaseStudy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CaseStudyRepository extends JpaRepository<CaseStudy, Long> {
}
