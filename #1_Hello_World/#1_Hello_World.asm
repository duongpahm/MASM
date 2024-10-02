;1.Hello World 
;Viet chuong trinh in ra dong chu "Hello, World!"
include Irvine32.inc ; goi thu vien Irvine

.data	;khai bao du lieu
	output db "Hello World!", 0 ;dinh nghia mot chuoi va ket thuc bang null, moi phan tu co kich thuoc 1 byte
	consoleHandle HANDLE ?  ;khai bao bien kieu du lieu handle chua co gia tri de xu ly dau ra chuan
	outputSize dd ($-output) ;bien luu do dai cua chuoi can in ra ouputSize = 13
	bytesWritten dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao (do dai dau ra thuc su (so byte da ghi))
.code 
	main proc ;khai bao ham main
		invoke GetStdHandle, STD_OUTPUT_HANDLE ;lay handle cua dau ra console (dung goi ham WriteConsole) duoc luu o eax
		mov consoleHandle, eax ;truyen doi so de goi ham WriteConsole tu eax

		invoke WriteConsole, ;goi ham de thuc thi in ra output
			  consoleHandle, ;handle de thuc thi lenh
			  ADDR output, ;dia chi cua ouput
			  outputSize, ;do dai cua ouput
			  ADDR bytesWritten, ;so ki tu da ghi 
			  0	;ket thuc 

		invoke ExitProcess, 0	;ket thuc qua trinh
	main endp ;ket thuc ham main
end main ;ket thuc chuong trinh




