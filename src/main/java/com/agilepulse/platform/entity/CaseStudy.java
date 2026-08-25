package com.agilepulse.platform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "case_studies")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CaseStudy {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    private String imageUrl;
}
