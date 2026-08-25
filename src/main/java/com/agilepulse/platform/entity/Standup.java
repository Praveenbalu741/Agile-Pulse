package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Entity
@Table(name = "standups")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Standup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String teamMember;
    private String yesterday;
    private String today;
    private String blockers;
    private String status; // TO_DO, IN_PROGRESS, REVIEW, DONE
    
    private LocalDate date;

    // AI Sentiment Features
    private Double sentimentScore;
    private Boolean isAtRisk;
}
