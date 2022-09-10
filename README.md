# GAME---Population-PascalABC-
Игра «Жизнь» или «Эволюция»

Игру «Жизнь» придумал английский математик Джон Конвей в 1970 году. В её основе игры
лежит математическая теория клеточных автоматов. 
Правила игры:

1) Место действия этой игры — «вселенная» — это размеченная на клетки поверхность
или плоскость — безграничная, ограниченная, или замкнутая (в пределе —
бесконечная плоскость).

2) Каждая клетка на этой поверхности является самостоятельной единицей и может
находиться в двух состояниях: быть «живой» (заполненной) или быть «мёртвой»
(пустой). Клетка имеет восемь соседей, окружающих её. Состояние каждой клетки
зависит от состояния окружающих её клеток.
3) Распределение живых клеток в начале игры называется первым поколением и
задается пользователем(человеком). Такимобразомсоздаётся как-бы колония живых
организмов.

4) Каждое следующее поколение рассчитывается на основе предыдущего по следующим
правилам (законы эволюции):

** если у живой клетки есть две или три живые соседки, то эта клетка
продолжает жить;

** в противном случае, если соседей меньше двух, то клетка умирает от
малочисленности («от одиночества»), а если больше трёх, то клетка умирает
от перенаселённости;

** в пустой (мёртвой) клетке, рядом с которой соседствует ровно три живые
клетки, зарождается жизнь (клетка становится живой);

** правила необходимо применять одновременно ко всем клеткам; процесс
рождения и смерти происходит одновременно, поэтому для каждого
поколения родившиеся клетки не влияют на смерть или выживание
окружающих клеток, а умершие на рождение или смерть других.


5) Игра заканчивается, если

** на поле не останется ни одной «живой» клетки (мертвый мир)

** конфигурация на очередном шаге в точности (без сдвигов и поворотов)
повторит себя же на одном из более ранних шагов (складывается
периодическая конфигурация) (периодический мир)

** при очередном шаге ни одна из клеток не меняет своего состояния
(складывается стабильная конфигурация; для общности можно сказать, что
это предыдущее правило, вырожденное до одного шага назад) (неизменный
(стабильный) мир)
