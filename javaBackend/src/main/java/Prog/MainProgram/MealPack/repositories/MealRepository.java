package Prog.MainProgram.MealPack.repositories;

import Prog.MainProgram.MealPack.entity.meal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MealRepository extends JpaRepository<meal, Integer> {

    Optional<meal> findByMealId(int checkId);

    Optional<meal> findByMealName(String mealName);
}
