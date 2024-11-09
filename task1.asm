section .data
    a db 5                ; Визначаємо a = 5
    b db 3                ; Визначаємо b = 3
    c db 2                ; Визначаємо c = 2
    resultMsg db 'Result: ', 0  ; Повідомлення перед результатом
    newline db 0x0A       ; Символ нового рядка

section .bss
    result resb 1         ; Змінна для збереження результату

section .text
    global _start

_start:
    ; Обчислюємо вираз b - c + a
    mov al, [b]           ; Завантажуємо b в al
    sub al, [c]           ; Віднімаємо c від al
    add al, [a]           ; Додаємо a до al
    mov [result], al      ; Зберігаємо результат у змінну result

    ; Перетворення результату в ASCII
    mov al, [result]      ; Завантажуємо результат
    add al, '0'           ; Перетворюємо його в ASCII символ
    mov [result], al      ; Зберігаємо ASCII-значення назад у result

    ; Виведення повідомлення
    mov eax, 4            ; Системний виклик sys_write (номер 4)
    mov ebx, 1            ; Файловий дескриптор 1 (stdout)
    mov ecx, resultMsg    ; Адреса повідомлення для виводу
    mov edx, 8            ; Довжина повідомлення ("Result: " + null byte)
    int 0x80              ; Виклик системного переривання

    ; Виведення результату
    mov eax, 4            ; Системний виклик sys_write
    mov ebx, 1            ; Файловий дескриптор stdout
    lea ecx, [result]     ; Адреса результату для виводу
    mov edx, 1            ; Довжина одного символу
    int 0x80              ; Виклик системного переривання

    ; Виведення нового рядка
    mov eax, 4            ; Системний виклик sys_write
    mov ebx, 1            ; Файловий дескриптор stdout
    mov ecx, newline      ; Адреса символу нового рядка
    mov edx, 1            ; Довжина символу
    int 0x80              ; Виклик системного переривання

    ; Завершення програми
    mov eax, 1            ; Системний виклик sys_exit (номер 1)
    xor ebx, ebx          ; Код завершення програми 0
    int 0x80              ; Виклик системного переривання
