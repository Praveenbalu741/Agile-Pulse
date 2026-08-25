package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "kudos")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Kudo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String sender;
    private String receiver;
    private String message;
}
