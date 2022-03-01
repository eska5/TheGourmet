package Prog.MainProgram.MealPack.services;

import Prog.MainProgram.MealPack.entity.meal;
import Prog.MainProgram.MealPack.repositories.MealRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;
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

    public Optional<meal> find(String mealName) {
        return mealRepository.findByMealName(mealName);
    }


    public List<meal> findAll() {
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
