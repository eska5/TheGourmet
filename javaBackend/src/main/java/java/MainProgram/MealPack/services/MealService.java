package java.MainProgram.MealPack.services;

import java.MainProgram.MealPack.DTO.ReadAllMeals;
import java.MainProgram.MealPack.entity.meal;
import java.MainProgram.MealPack.repositories.MealRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class MealService {

    private MealRepository mealRepository;


    @Autowired
    public MealService(MealRepository mealRepository) {
        this.mealRepository = mealRepository;
    }

    public Optional<meal> find(int checkId) {
        return mealRepository.findByMealId(checkId);
    }


    public List<ReadAllMeals.meal> findAll() {
        return mealRepository.findAll();
    }


    @Transactional
    public meal save(meal newMeal) {
        return mealRepository.save(newMeal);

    }

    @Transactional
    public void delete(int checkId) {
        mealRepository.deleteById(checkId);
    }

    @Transactional
    public void update(meal newMeal) {
        mealRepository.save(newMeal);
    }

}
