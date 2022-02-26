package java.MainProgram.MealPack.repositories;

import java.MainProgram.MealPack.entity.meal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MealRepository extends JpaRepository<meal, Integer> {

    Optional<meal> findByMealId(int mealId);

    List<meal> findByMeal(meal meal);
}
