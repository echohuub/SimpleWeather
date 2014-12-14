//
//  Temperature.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

typedef struct {
    int celsius;
    int fahrenheit;
} Temperature;

static inline Temperature temperatureMake(int celsius, int fahrenheit) {
    return (Temperature){celsius, fahrenheit};
}
