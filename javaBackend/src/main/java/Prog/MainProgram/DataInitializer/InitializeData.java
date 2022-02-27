package Prog.MainProgram.DataInitializer;

import Prog.MainProgram.MealPack.entity.meal;
import Prog.MainProgram.MealPack.services.MealService;
import java.io.IOException;
import java.io.InputStream;

import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class InitializeData {

/*
    private final MealService mealService;


    @Autowired
    public InitializeData(MealService mealService) {
        this.mealService = mealService;
    }

    @PostConstruct
    private synchronized void init() throws IOException {

        meal mealOne = meal.builder()
                .mealName("Sachajko")
                .mealPhoto(getResourcesAsByteArray("C:\\Users\\Kuba\\Desktop\\Nowy folder (3)\\javaBackend\\src\\main\\resources\\photosinit\\testZero.png"))
                .build();

        meal mealTwo = meal.builder()
                .mealName("kk")
                .mealPhoto(getResourcesAsByteArray("C:\\Users\\Kuba\\Desktop\\Nowy folder (3)\\javaBackend\\src\\main\\resources\\photosinit\\testZero.png"))
                .build();

        meal mealThree = meal.builder()
                .mealName("kek")
                .mealPhoto(getResourcesAsByteArray("C:\\Users\\Kuba\\Desktop\\Nowy folder (3)\\javaBackend\\src\\main\\resources\\photosinit\\testZero.png"))
                .build();


        mealService.save((mealOne));
        mealService.save((mealTwo));
        mealService.save((mealThree));

    }


    private byte[] getResourcesAsByteArray(String photo) throws IOException {
        try (InputStream is = this.getClass().getResourceAsStream(photo)) {
        return is.readAllBytes();
        }

    }

 */

}
