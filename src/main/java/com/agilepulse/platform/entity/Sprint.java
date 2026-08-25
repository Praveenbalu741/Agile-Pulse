package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "sprints")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Sprint {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Integer velocity; // gauge chart
    private Integer completedPoints;
    private Integer totalPoints;
    private Integer teamMorale; // out of 10
}
