package Prog.MainProgram.MealPack.entity;

import lombok.*;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
@Table(name = "meals")

public class meal {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private int mealId;
    private String mealName;
    @Lob @Basic(fetch =FetchType.LAZY)
    @Column(length=1000000)
    @ToString.Exclude
    private byte[] mealPhoto;

}
