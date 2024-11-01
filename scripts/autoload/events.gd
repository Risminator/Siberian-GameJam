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
