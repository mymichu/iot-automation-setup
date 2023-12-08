#include <B-L475E-IOT01/stm32l475e_iot01_gyro.h>

#include "SystemClock.h"
#include "blinky/blinky.h"
#include "eiger/scheduler.h"
#include "indication/indication.h"
#include "movement/movement.h"
#include <unistd.h>
#include <errno.h>
void platform_init() {
    HAL_Init();
    SystemClock_Config();
    BSP_LED_Init(LED_GREEN);
    BSP_GYRO_Init();
    BSP_GYRO_LowPower(0);
}

eiger_scheduler scheduler = NULL;
void setup() {
    const uint8_t blinky_update_time_ms = 100;
    const uint8_t movement_update_time_ms = 20;

    platform_init();
    indication indicator = indication_create(
        LED_GREEN, (void (*)(int))BSP_LED_On, (void (*)(int))BSP_LED_Off);

    timer timerIndicationOn = eiger_timer_create(blinky_update_time_ms);
    movement hw_movement = movement_create(BSP_GYRO_GetXYZ);
    blinky_init(timerIndicationOn, indicator, hw_movement);
    scheduler = eiger_scheduler_create(HAL_Delay);
    eiger_scheduler_add_task(scheduler, blinky_update, blinky_update_time_ms);
    eiger_scheduler_add_task(scheduler, (void (*)(void))movement_run,
                             movement_update_time_ms);
}

int main() {
    setup();
    while (1) {
        if (!eiger_scheduler_update(scheduler)) {
            break;
        }
    }
    return -1;
}

void assert_failed(char *file, uint32_t line) {}

void _exit(int status) {
    while (1) {
    }
}

// File descriptor close stub
int _close(int file) {
    errno = EBADF;
    return -1;
}

// File position seek stub
_off_t _lseek(int file, _off_t ptr, int dir) {
    errno = ESPIPE;
    return -1;
}

// File read stub
ssize_t _read(int file, void *ptr, size_t len) {
    errno = EBADF;
    return -1;
}

// File write stub
ssize_t _write(int file, const void *ptr, size_t len) {
    errno = EBADF;
    return -1;
}