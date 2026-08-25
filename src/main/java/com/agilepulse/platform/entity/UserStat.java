package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user_stats")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserStat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private Integer xp;
    private Integer level;
    private Integer currentStreak;

    @ElementCollection(fetch = FetchType.EAGER)
    @Builder.Default
    private List<String> unlockedBadges = new ArrayList<>();
}
