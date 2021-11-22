1) обновил уже стоял VirtualBox
2) поставил Vagrant почитал что такое
3) взял стандартный терминал винды
4) создал и запустил машину
5) с интерфейсом VB знаком, Vagrant выделил 1Гб ОП 2ядра 
6) что бы поменять ОП:
    6.1) выключить машину vagrant halt
    6.2) и в файл Vagrantfile добавить    
          config.vm.provider "virtualbox" do |vb|
             vb.memory = "2048"
          end
7) подключился попрактиковался
8) man history | grep -n length // тип int history_length 296 строка, строка 199 строка описане
8.1)  man bash | grep ignoreboth
A value of ignoreboth is shorthand for ignorespace and ignoredups
// своими словами, это значение параметра HISTCONTROL, которое сочетает в себе ignorespace and ignoredups
9) man bash | grep -n -i '{'
    230         { list; }
    list  is  simply  executed in the current shell environment.  list must be terminated with a newline or semicolon.  This is known as a group
    command.  The return status is the exit status of list.  Note that unlike the metacharacters ( and ), { and } are reserved  words  and  must
    occur where a reserved word is permitted to be recognized.  Since they do not cause a word break, they must be separated from list by white‐
    space or another shell metacharacter.
10) touch {000001..100000}.txt //30k создать не удалось, слишком большой диапазан, пытался накопать в манах, не нашел(
11) man bash | grep -n '\[\['
    [[ expression ]]
    241   Return  a  status of 0 or 1 depending on the evaluation of the conditional expression expression. 
    // [[ -d /tmp ]] условие на наличие каталога, если 0 нету если 1 есть
12) mkdir /tmp/new_path_dir/
    cp /bin/bash /tmp/new_path_dir/
    PATH=/tmp/new_path_dir/:$PATH
    type -a bash
13) man batch
       at and batch read commands from standard input or a specified file which are to be executed at a later time, using /bin/sh.
       at      executes commands at a specified time.
       batch   executes commands when system load levels permit; in other words, when the load average drops below 1.5, or the value specified in the  in‐vocation of atd.
    //перевести :) (команда at используется для назначения одноразового задания на заданное время, а команда batch — для назначения одноразовых задач, которые должны выполняться, когда загрузка системы становится меньше 1.5)
14) exit + vagrant halt