package java.MainProgram.MealPack.DTO;

import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.List;
import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class ReadAllMeals {

    @Singular
    private List<meal> meals;

    public static Function<List<meal>, ReadAllMeals> entityToDtoMapper() {
        return meals -> {
            ReadAllMealsBuilder response = ReadAllMeals.builder();
            meals.stream()
                    .map(meal -> meal.builder()
                            .mealId(meal.getMealId())
                            .mealName(meal.getMealName())
                            .mealPhoto(meal.getMealPhoto())
                            .build())
                    .forEach(response::meal);
            return response.build();
        };
    }

    @Getter
    @Setter
    @NoArgsConstructor
    @SuperBuilder
    public static class meal {

        private int mealId;
        private String mealName;
        private byte[] mealPhoto;
    }

}
