package Prog.MainProgram.MealPack.DTO;

import Prog.MainProgram.MealPack.entity.meal;
import lombok.*;

import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class ReadMeal {

    private int mealId;
    private String mealName;
    private String mealPhoto;

    public static Function<meal, ReadMeal> entityToDtoMapper() {
        return meal -> ReadMeal.builder()
                .mealId(meal.getMealId())
                .mealName(meal.getMealName())
                .mealPhoto(meal.getMealPhoto())
                .build();
    }
}
