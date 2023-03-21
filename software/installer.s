.include "lib/kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

; when running the installer, we need to be inside /boot because the mkbin system call
; creates all binary files inside whatever is the current directory
; and we want the kernel to live inside /boot
bootloader_installer:
;; create the kernel file
  mov d, s_warning
  call puts
  mov d, s_enter_filename
  call puts
  mov d, kernel_filename
  call gets

  mov d, s_prompt 
  call puts
	mov d, kernel_filename
	mov al, 6               ; mkbin
	syscall sys_filesystem      ; create the binary file for the kernel
                          ; we need to be on '/boot' here

  mov si, kernel_filename
  mov di, kernel_fullpath
  call strcat             ; form full pathname for the kernel file
	mov d, kernel_fullpath
	mov al, 19
	syscall sys_filesystem		; obtain dirID for kernel file, in A
	inc a					; increment LBA because data starts after the header sector
	syscall sys_boot_install

	syscall sys_terminate_proc



s_warning:        .db "Make sure you are in "
									.db "/boot before creating "
									.db "the file.\n", 0

s_prompt:         .db "% ", 0
s_enter_filename: .db "Kernel filename: ", 0
kernel_filename:    .fill 64, 0
kernel_fullpath:  	.db "/boot/"
                    .fill 64, 0

.include "lib/stdio.asm"


.end



