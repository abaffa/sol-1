.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

; when running the installer, we need to be inside /boot because the mkbin system call
; creates all binary files inside whatever is the current directory
; and we want the kernel to live inside /boot
bootloader_installer:
;; create the kernel file
  push bp
  mov bp, sp

  mov d, s_warning
  call puts

  leave
	syscall sys_terminate_proc



s_warning:        .db "Make sure you are in "
									.db "/boot before creating "
									.db "the file.\n", 0

s_prompt:         .db "% ", 0
s_enter_filename: .db "Kernel filename: ", 0
kernel_filename:    .fill 64, 0
kernel_fullpath:  	.db "/boot/"
                    .fill 64, 0

.include "stdio.asm"


.end



