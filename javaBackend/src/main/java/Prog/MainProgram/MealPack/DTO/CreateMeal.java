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
public class CreateMeal {

    private int mealId;
    private String mealName;
    private byte[] mealPhoto;

    public static Function<CreateMeal, meal> dtoToEntityMapper(Function<String, meal> schoolFunction) {
        return CreateMeal -> meal.builder()
                .mealId(CreateMeal.getMealId())
                .mealName(CreateMeal.getMealName())
                .mealPhoto(CreateMeal.getMealPhoto())
                .build();
    }
}
