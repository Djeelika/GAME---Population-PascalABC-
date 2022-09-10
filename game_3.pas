Program game; 

uses crt;
type
  myArr = array[1..130] of integer; 
  myArrI = array[1..130] of (integer,integer);
  matrix = array[0..130, 0..130] of integer;
  myArrayMatrix = array[1..10000] of matrix; 
  
const
 YY = 29;  //Строки
 XX = 120; //Столбцы
var
  A, B, C, D, Popul, Popul2: matrix;
  MinMaxX, MinMaxY: myArrI;
  Epochs:myArrayMatrix;
  MinY, MaxY, MinX,MaxX, count_units: integer;
  i,j,dx,dy, x, y, era, status_end, count,krug, step : integer;
  flag, endOfGame: boolean;
  ps  : char;
  FilePopulation: text;

procedure welcome();  
begin
  textbackground (7);   //Фон будет (серый цвет)
  clrscr;               //Очистка экрана и применении цвета фона
  
  textcolor (5);    //Текст будет Фиолетовый
  gotoxy (50,8);    //Курсор в точке по центру экрана (x,y)
  write ('Игра Эволюция!');
  gotoxy (40,11);
  write ('создать организм/удалить - Z/X');
  gotoxy (40,12);
  write ('управляющие кнопки - 4, 2, 6, 8 ');
  gotoxy (40,13);
  write ('для начала игры - кнопка пробел.');
  
  delay (4000);  //Задержка
  clrscr;        //Очистка экрана
end;  

procedure goodbye(era,status_end, cycle:integer);  
begin
  textbackground (7);   //Фон будет (серый цвет)
  //clrscr;               //Очистка экрана и применении цвета фона
  
  textcolor (0);    //Текст будет Фиолетовый(5)
  gotoxy (50,8);    //Курсор в точке по центру экрана (x,y)
  write ('Игра ОКОНЧЕНА!');
  gotoxy (50,11);
  write ('эра окончания №', era);
  gotoxy (50,14);
  if status_end = 1 then
    write ('Стабильный Мир');
  
  if status_end = 2 then
    write ('Переодический Мир. Цикл через ', cycle, ' эпохи.');
  
  if status_end = 0 then
    write ('Мeртвый Мир');
  
  delay (4000);  //Задержка
  clrscr;        //Очистка экрана
end;  



procedure kvadrat();
  var 
  i,j:integer;
begin
    textbackground (7);   //Фон будет (серый цвет)
    clrscr;               //Очистка экрана и применении цвета фона
    textcolor (5);       //Текст будет 13 розовым цветом/ 5 Фиолетовый

    for i:=1 to XX do     // Столбцы 
      for j:=1 to YY do    // Строки 
        begin
          if (j=1) or (j=YY) then   // если строка 1 или N , т.е. рисуем горизонтально
            begin
            gotoxy (i,j);           //Курсор в точке (столбец, строка)
            write ('&');
            end;
          if (j<>1)and(j<>YY) then   //  рисуем вертикально
            begin
              gotoxy (1, j);         // (столбец, строка), все строки по первому столбцу
              write ('&');
              gotoxy (XX, j);       //Курсор в точке, самый правый столбец, горизонтально
              write ('&');
            end
         end; 
end;


function inputMatrix_random(k,t: integer):matrix;    // Заполнение Matrix
var
  x: matrix;
  i,j: integer;
begin
  for i:=1 to k do
    for j:= 1 to t do
      x[i,j]:= random(20);
  result:=x;
end;
procedure outputMatrix(k,t:integer; x: matrix);   // Вывод Matrix
var
  i,j: integer;
begin
  for i:=1 to k do begin
    for j:= 1 to t do
    write(x[i,j]:3);
  writeln;
  end;
end; 

procedure outputArrKortezh(m:integer; x: myArrI);   // Вывод массива
var
  i: integer;
begin
  for i:=1 to m do 
    write(x[i]:4);
  writeln;
end; 

// поиск MinMaxX
procedure searchMinMaxX(Var min:integer; Var max: integer; A:matrix); 
var
  i, j : integer;
begin
  max:= 1;
  min:= XX;
  
  for i:=1 to YY do begin
    for j:=1 to XX-1 do begin
      if ((A[i,j] = 1)and (j < min ))then begin
        min:=j;
        break;
        end;
     end;
     
    for j:= XX downto 2 do begin
      if ((A[i,j] = 1) and (j> max)) then  begin
        max:=j;
        break;
      end;
     end;
     
  end; 
end; 


// поиск MinMaxY
procedure searchMinMaxY(Var min:integer; Var max: integer; A:matrix); 
var
  i, j: integer;
begin
  max:= 1;
  min:= YY;
  
  for j:=1 to XX do begin
    for i:=1 to YY-1 do begin
      if ((A[i,j] = 1)and (i < min ))then begin
        min:=i;
        break;
        end;
      end;
      
    for i:= YY downto 2 do begin
      if ((A[i,j] = 1) and (i> max)) then begin
        max:=i;
        break;
      end;
    end;
    
  end; 
end; 


procedure сreatingPopulation(Var minY:integer; Var maxY: integer ; Var minX:integer; Var maxX: integer; Var count_units:integer; Var Popul:matrix);
var
  i,j,dx,dy, x, y : integer;
  flag: boolean;
  ps  : char;
begin
  x:= 60;
  y:= 14;
  gotoxy (x,y); // по центру экрана
  dx:= 0;
  dy:= 0;
  count_units:=0;
  
  ps:='*';
  while ps <> ' ' do begin
    if keyPressed then 
       ps:= readKey 
    else continue;
    
    //стираем собачку
    gotoXY(x,y);
    if Popul[y,x] = 1 then write('*') else write(' ');
    
    if (ps = ' ') then begin //СОХРАНЯЕМ
      searchMinMaxX(minX, maxX, Popul);
      searchMinMaxY(minY, maxY, Popul);
      //result:= Popul;
      end
    else begin
      if ps = '4' then begin
        dx:= -1;
        dy:= 0;
        end
      else begin
        if ps = '6' then begin
          dx:= 1;
          dy:= 0;
          end
        else begin
          if ps = '8' then begin
            dx:= 0;
            dy:= -1;
            end
          else begin
            if ps = '2' then begin
              dx:= 0;
              dy:= 1;
              end
            else begin
              dx:= 0;
              dy:= 0;
              end
          end;
        end;
      end;
    end;
    x:= x + dx;
    y:= y + dy;
   
    //выводим собачку
    gotoXY(x,y); write('@'); 
   
   
    // Создаем популяцию
    if ps = 'z' then begin
      gotoxy (x,y);
      write ('*');
      Popul[y,x]:=1;
      inc(count_units);
      end
    else begin
      if (ps = 'x') and (Popul[y,x] = 1) then begin
        gotoxy (x,y);
        write (' ');
        Popul[y,x]:= 0;
        dec(count_units);
        end
      else
        continue;
    end;

  end;
end;


// Считаем Соседей вокруг
function сountingNeighbors(i:integer; j:integer; x: matrix ): integer;
var
  sum: integer;
begin
  sum:= 0;
  if x[i-1, j-1]= 1 then
    inc(sum);
  if x[i-1, j]=1 then
    inc(sum);
  if x[i-1, j+1]=1 then
    inc(sum);
  if x[i, j+1]=1 then
    inc(sum);
  if x[i+1, j+1]=1 then
    inc(sum);
  if x[i+1, j]=1 then
    inc(sum);
  if x[i+1, j-1]=1 then
    inc(sum);
  if x[i, j-1]=1 then
    inc(sum);

  result:= sum;
end;

// Создаем Новую Популяцию
function creatingNewPopulation(MinY, MaxY, MinX, MaxX:integer; Var count_units:integer; Popul:matrix):matrix;
var
  Popul2:matrix;
  i,j,count: integer;
  flag: boolean;
begin
  textbackground (7);   //Фон будет (серый цвет)
  clrscr;              //Очистка экрана
  textcolor (5);      //Текст будет Фиолетовый
  
  count_units:=0;    // Обнуляем число организмов
  
  for i:=MinY-1 to MaxY+1 do begin
      for j:= MinX-1 to MaxX+1 do begin
          // получили количество соседей у точки
          count:= сountingNeighbors(i, j, Popul);
          // рождается Новая
          if ((count=3) and (Popul[i, j]=0)) then begin
              gotoxy (j,i);
              write ('o');      
              Popul2[i, j]:=1;
              inc(count_units);
          end;
          // умерает
          if ((count < 2) or(count >3))and (Popul[i, j]=1) then begin 
              gotoxy (j,i);
              write ('X');
              Popul2[i, j]:=0;
          end;
          // остается жить
          if ((count = 2) or (count = 3)) and (Popul[i, j]=1) then begin  
              gotoxy (j,i);
              write ('*');
              Popul2[i, j]:=1;
              inc(count_units);
          end;
      end;
  end;
  delay(300);
  result:= Popul2;
end;

procedure status(era, count:integer);
begin
  // выводим состояние
  textcolor (0);
  gotoxy (4,30);
  write ('Номер эры: ', era);
  textcolor (0);
  gotoxy (30,30);   // (95,30) (30,30)
  write ('Количество живых организмов: ', count);
end;

// рисуем созданную Популяцию
procedure DrawingPopulation(MinY, MaxY, MinX, MaxX, era, count_units:integer; Popul:matrix);
var
  i,j,count: integer;
begin
  textbackground (7);   //Фон будет (серый цвет)
  clrscr;              //Очистка экрана
  textcolor (5);      //Текст будет Фиолетовый
  
  for i:=MinY to MaxY do 
      for j:= MinX to MaxX do 
        if (Popul[i, j]=1) then begin
          gotoxy (j,i);
          write ('*');
        end;
  
  // выводим состояние
  status(era, count_units);
  delay(10);
end;

// проверка окончания игры
function checkEndOfGame(MinY, era:integer; Epochs:myArrayMatrix): boolean;
var
  i,j, cycle: integer;
  flag: boolean;
begin
  flag:= false;
  
    if (MinY=-1)then begin                  // мертвый мир
      flag:= true;
      cycle:= 0;
      status_end:= 0;
      goodbye(era, status_end, cycle);
      result:= flag;
      end;
      
    if Epochs[era]= Epochs[era-1]then begin // стабильный
      flag:= true;
      cycle:= 0;
      status_end:=1;
      goodbye(era, status_end,cycle);
      result:= flag;
      end;
  
    for i:=1 to era-1 do begin
      if Epochs[i]= Epochs[era] then begin // переoдический
        flag:= True;
        cycle:= era-i; 
        status_end:=2;
        goodbye(era, status_end, cycle);
        result:= flag;
      end;
    end;
    
  result:= flag;
end;



BEGIN
  endOfGame:= False;
  welcome();
  kvadrat();
  textcolor (5);  //Текст будет Фиолетовый
  status_end:= -1;
  era:=1;
  // Создали начальную популяцию, получили MinMax
  сreatingPopulation(MinY, MaxY, MinX,MaxX, count_units, Popul);
  Epochs[era]:= Popul;       // Сохранили популяцию
   
  
  // выводим состояние
  status(era, count_units);
  
  //-----------------------------------------------
  while not endOfGame do begin
    inc(era);         // Новая Популяция, на основе предыдущих значений
    Popul:= creatingNewPopulation(MinY, MaxY, MinX,MaxX, count_units, Popul);  
     
    Epochs[era]:= Popul;   // Сохранили Новую популяцию

    //поиск новых MinMax
    MinY:=-1;
    MaxY:=-1;
    MinX:=-1;
    MaxX:=-1;
    searchMinMaxX(minX, maxX, Popul);
    searchMinMaxY(minY, maxY, Popul);
    

    // рисуем созданную Популяцию
    DrawingPopulation(MinY, MaxY, MinX,MaxX, era, count_units, Popul);
    
    // проверка окончания игры
    endOfGame:= checkEndOfGame(MinY, era, Epochs);
    
  
  end;
  
  
  
 
end.

