package Prog.MainProgram.MealPack.controller;

import Prog.MainProgram.MealPack.DTO.CreateMeal;
import Prog.MainProgram.MealPack.DTO.ReadMeal;
import Prog.MainProgram.MealPack.DTO.UpdateMeal;
import Prog.MainProgram.MealPack.DTO.ReadAllMeals;
import Prog.MainProgram.MealPack.entity.meal;
import Prog.MainProgram.MealPack.services.MealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Optional;

@RestController
@RequestMapping("api/meals")
public class MealController {

   private final MealService mealService;

    @Autowired
    public MealController(MealService mealService) {
        this.mealService = mealService;
    }

    @GetMapping
    public ResponseEntity<ReadAllMeals> getMeals() {
        return ResponseEntity.ok(ReadAllMeals.entityToDtoMapper().apply(mealService.findAll()));
    }

    @GetMapping("{mealId}")
    public ResponseEntity<ReadMeal> getMeal(@PathVariable("mealId") int id) {
        Optional<meal> meal = mealService.find(id);
        return meal.map(value -> ResponseEntity.ok(ReadMeal.entityToDtoMapper().apply(value)))
                .orElseGet(() -> ResponseEntity.notFound().build());

    }

    @PostMapping
    public ResponseEntity<Void> createMeal(@RequestBody CreateMeal request, UriComponentsBuilder builder) {
        meal meal = CreateMeal
                .dtoToEntityMapper(mealName -> mealService.find(request.getMealName()).orElseThrow())
                .apply(request);
        meal = mealService.save(meal);
        return ResponseEntity.created(builder.pathSegment("api", "meals", "{mealId}")
                .buildAndExpand(meal.getMealId()).toUri()).build();

    }

    @DeleteMapping("{mealId}")
    public ResponseEntity<Void> deleteMeal(@PathVariable("mealId") int id) {
        Optional<meal> meal = mealService.find(id);
        if (meal.isPresent()) {
            mealService.delete(meal.get().getMealId());
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("{mealId}")
    public ResponseEntity<Void> updateMeal(@RequestBody UpdateMeal request, @PathVariable("mealId") int id) {
        Optional<meal> meal = mealService.find(id);
        if (meal.isPresent()) {
            UpdateMeal.dtoToEntityUpdater().apply(meal.get(), request);
            mealService.update(meal.get());
            return ResponseEntity.accepted().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}
