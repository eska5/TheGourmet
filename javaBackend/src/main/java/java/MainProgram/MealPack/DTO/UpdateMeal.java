package java.MainProgram.MealPack.DTO;

import java.MainProgram.MealPack.entity.meal;
import lombok.*;

import java.util.function.BiFunction;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class UpdateMeal {

    private int mealId;
    private String mealName;
    private byte[] mealPhoto;

    public static BiFunction<meal, UpdateMeal, meal> dtoToEntityUpdater() {
        return (meal, UpdateMeal) -> {
            meal.setMealName(UpdateMeal.getMealName());
            meal.setMealPhoto(UpdateMeal.getMealPhoto());
            return meal;
        };
    }
}
