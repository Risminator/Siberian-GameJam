extends Node

# Начало перехода на сцену new_scene
@warning_ignore("unused_signal")
signal transition_start(new_scene: Global.GAME_SCENES)
# Конец перехода на сцену new_scene
@warning_ignore("unused_signal")
signal transition_complete(new_scene: Global.GAME_SCENES)

# Будет использоваться, когда мы прошли абсолютно все локации
@warning_ignore("unused_signal")
signal game_win

# Ещё нигде не применялось, но можно использовать, если вдруг сделаем настройки громкости
@warning_ignore("unused_signal")
signal volume_changed

# Это нигде не считывается, мы просто отправляем этот сигнал для тряски камеры на выбранное кол-во символов
# signal screen_shake

### В ТАВЕРНЕ

# На кнопку мини-игры навелись
@warning_ignore("unused_signal")
signal minigame_hover(minigame: Global.MINI_GAMES)
# Курсор от кнопки-мини-игры отвели
@warning_ignore("unused_signal")
signal minigame_hover_stopped(minigame: Global.MINI_GAMES)
# На кнопку мини-игры нажали
@warning_ignore("unused_signal")
signal minigame_pressed(_minigame: Global.MINI_GAMES)
# Мини-игра была выбрана
@warning_ignore("unused_signal")
signal minigame_chosen(minigame: Global.MINI_GAMES)
# Из мини-игры вышли
@warning_ignore("unused_signal")
signal return_to_tavern(minigame: Global.MINI_GAMES)
# Пошли в битву из таверны
@warning_ignore("unused_signal")
signal go_to_battle

### ВЗАВИМОДЕЙСТВИЯ СО СЦЕНОЙ В МИНИ-ИГРАХ

# Предмет взяли
@warning_ignore("unused_signal")
signal prop_taken
# Предмет отпустили
@warning_ignore("unused_signal")
signal prop_dropped
# Выполнена задача мини-игры, она закончена, щас будет выход в таверну
@warning_ignore("unused_signal")
signal minigame_completed
# Кусок бороды отрезан
@warning_ignore("unused_signal")
signal beard_cut
# В слот положили предмет
@warning_ignore("unused_signal")
signal slot_set

### Счастье

# Счастье изменилось
@warning_ignore("unused_signal")
signal happiness_updated(before: int, after: int)
# Частный случай: Счастье увеличилось
# signal happiness_increased(before: int, after: int)
# Частный случай: Счастье уменьшилось
# signal happiness_decreased(before: int, after: int)
# Частный случай: Счастье максимальное
@warning_ignore("unused_signal")
signal happiness_maxed

### Бой

# Герой атаковал
@warning_ignore("unused_signal")
signal hero_attack
# Монстр умер / получил урон
@warning_ignore("unused_signal")
signal monster_dead
# Монстр ударил героя
@warning_ignore("unused_signal")
signal monster_attack
