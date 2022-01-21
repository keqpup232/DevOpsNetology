1) не очень понимаю что значит какого типа команда cd. Команда(по сути программа) которая СТАНДАРТНО доступна в bash.  
2) grep <some_string> <some_file> -c 
3) systemd
4) ls 2 > /dev/pts/X
5) cat < test.in > test.out
6) Да можно увидеть с pty выводить в tty, как пример echo Hi > /dev/ttyX(надо переключаться между терминалами ctr+alt+FX) и в обратную сторону с терминала echo Hi > /dev/pts/X
7) bash 5>&1 - создаст дескриптор 5 и перенаправит его в stdout(1)
echo netology > /proc/$$/fd/5 - выведет в дескриптор 5, который был перенаправлен в stdout(1) и в терминале увидим netology
8) ls 5>&2 2>&1 1>&5 | grep X //
   1) 5>&2 - новый дескриптор перенаправили в stderr 
   2) 2>&1 - stderr перенаправили в stdout 
   3) 1>&5 - stdout - перенаправили в в новый дескриптор
9) переменные окружения, printenv, env

10) man proc | grep cmdline -n
    1) /proc/<PID>/cmdline полный путь до исполняемого файла процесса [PID]
    2) пример cat /proc/$$/cmdline -- bash
    3) 202                /proc/[pid]/cmdline
    4) 203                This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case,  there
    5) 204                is  nothing in this file: that is, a read on this file will return 0 characters.  The command-line arguments appear in this file
    6) 205                as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.
    7) ///
    8) man proc | grep exe -n
    9) /proc/<PID>/exe
    10) содержит ссылку до файла запущенного для процесса [PID],  cat выведет содержимое запущенного файла, запуск этого файла, запустит еще одну копию самого файла
    11) 250                /proc/[pid]/exe
    12) 251                Under Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.   This  symbolic
    13) 252                link can be dereferenced normally; attempting to open it will open the executable.  You can even type /proc/[pid]/exe to run an‐
    14) 253                other copy of the same executable that is being run by process [pid].  If the pathname has been unlinked, the symbolic link will
    15) 254                contain  the  string  '(deleted)'  appended to the original pathname.  In a multithreaded process, the contents of this symbolic
    16) 255                link are not available if the main thread has already terminated (typically by calling pthread_exit(3)).
    17) 256
    18) 257                Permission to dereference or read (readlink(2)) this symbolic link is governed by a ptrace access mode  PTRACE_MODE_READ_FSCREDS
    19) 258                check; see ptrace(2).
    20) 259
    21) 260                Under  Linux  2.0 and earlier, /proc/[pid]/exe is a pointer to the binary which was executed, and appears as a symbolic link.  A
    22) 261                readlink(2) call on this file under Linux 2.0 returns a string in the format:
    23) 262
    24) 263                    [device]:inode
    25) 264
    26) 265                For example, [0301]:1502 would be inode 1502 on device major 03 (IDE, MFM, etc. drives) minor 01 (first partition on  the  first
    27) 266                drive).
    28) 267
    29) 268                find(1) with the -inum option can be used to locate the file.
    30) 
11) cat /proc/cpuinfo | grep sse -- sse4_2

12) vagrant@vagrant:~$ ssh -t localhost 'tty'
    1) vagrant@localhost's password:
    2) /dev/pts/2
    3) Connection to localhost closed.
    
    4) By default, when you run a command on the remote machine using ssh, a TTY is not allocated for the remote session. This lets you transfer binary data, etc. without having to deal with TTY quirks.
    5) However, when you run ssh without a remote command, it DOES allocate a TTY, because you are likely to be running a shell session.
    6) It's expecting an interactive terminal on a tty device on the intermediate server.
    
    7) man ssh
    8) -t      Force pseudo-terminal allocation.  This can be used to execute arbitrary screen-based programs on a re‐
    9) mote machine, which can be very useful, e.g. when implementing menu services.  Multiple -t options force
    10) tty allocation, even if ssh has no local tty.
    11) //При подключении ожидается пользователь, а не другой процесс, и нет локального tty в данный момент

13)глянул как работает
    https://youtu.be/aXGagfPRM5s
    скачал // sudo apt install reptyr

в первом терминале запустил screen и узнал PID 2462 под /dev/pts/0

В втором терминале запускаю sudo reptyr -s 2462

Unable to attach to pid 2462: Permission denied
//Почему нет прав, нашел ответ тут http://tuxdiary.com/2014/08/08/reptyr/
//Ядро в защищеном режиме

sudo vim /etc/sysctl.d/10-ptrace.conf
kernel.yama.ptrace_scope = 0
sudo sysctl -p /etc/sysctl.d/10-ptrace.conf

после в первом терминале видим что все удалось
[1]+  Stopped                 screen

14)tee делает вывод в файл и stdout
echo string | sudo tee /root/new_file
команда получает вывод из stdin, перенаправленный через pipe от stdout команды echo
и так как команда запущена от sudo, имеет права на запись в файл
