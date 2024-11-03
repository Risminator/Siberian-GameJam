extends Node

# Начало перехода на сцену new_scene
signal transition_start(new_scene: Global.GAME_SCENES)
# Конец перехода на сцену new_scene
signal transition_complete(new_scene: Global.GAME_SCENES)

# Будет использоваться, когда мы прошли абсолютно все локации
signal game_win

# Ещё нигде не применялось, но можно использовать, если вдруг сделаем настройки громкости
signal volume_changed

# Это нигде не считывается, мы просто отправляем этот сигнал для тряски камеры на выбранное кол-во символов
signal screen_shake

### В ТАВЕРНЕ

# На кнопку мини-игры навелись
signal minigame_hover(minigame: Global.MINI_GAMES)
# Курсор от кнопки-мини-игры отвели
signal minigame_hover_stopped(minigame: Global.MINI_GAMES)
# На кнопку мини-игры нажали
signal minigame_pressed(minigame: Global.MINI_GAMES)
# Мини-игра была выбрана
signal minigame_chosen(minigame: Global.MINI_GAMES)
# Из мини-игры вышли
signal return_to_tavern(minigame: Global.MINI_GAMES)

### ВЗАВИМОДЕЙСТВИЯ СО СЦЕНОЙ В МИНИ-ИГРАХ

# Предмет взяли
signal prop_taken
# Предмет отпустили
signal prop_dropped
# Выполнена задача мини-игры, она закончена, щас будет выход в таверну
signal minigame_completed
# Кусок бороды отрезан
signal beard_cut
