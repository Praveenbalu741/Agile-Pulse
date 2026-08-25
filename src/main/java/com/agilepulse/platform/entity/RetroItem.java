package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "retro_items")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RetroItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String type; // START, STOP, CONTINUE
    private String content;
    private Integer votes;
}
