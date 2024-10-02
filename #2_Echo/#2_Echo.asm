;2.Echo
;Viet chuong trinh nhap doan van ban va in ra doan van ban do

include Irvine32.inc ; goi thu vien Irvine

inputSize = 32

.data ;khai bao du lieu 
	input db inputSize dup(?), 0	;khai bao mang co do dai bang inputSize(=100) va cac phan tu chua duoc khoi tao ket thuc la NULL
	stdInHandle HANDLE ? ;khai bao bien kich thuoc HANDLE chua duoc khoi tao
	stdOutHandle HANDLE ? ;khai bao bien kich thuoc HANDLE chua duoc khoi tao
	bytesRead dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao 
	bytesWritten dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao 
.code 
	main proc ;khai bao ham main
		invoke GetStdHandle, STD_INPUT_HANDLE ;lay handle cua dau vao console (dung goi ham ReadConsole) duoc luu o eax
		mov stdInHandle, eax ;truyen doi so de goi ham ReadConsole tu eax 

		;Nhap chuoi ki tu
		invoke ReadConsole, ;goi ham de thuc thi 
			stdInHandle, ;Handle de thuc thi lenh
			ADDR input, ;dia chi input de truyen du lieu tu ban phim
			inputSize, ;do dai cua input nhap vao toi da = 100
			ADDR bytesRead, ;do dai cua input duoc nhap vao
			0 ;ket thuc

		invoke GetStdHandle, STD_OUTPUT_HANDLE ;lay handle cua dau ra console (dung goi ham WriteConsole) duoc luu o eax
		mov stdOutHandle, eax ;truyen doi so de goi ham WriteConsole tu eax

		invoke WriteConsole, ;goi ham de thuc thi in ra output
			  stdOutHandle, ;handle de thuc thi lenh
			  ADDR input, ;dia chi cua input
			  bytesRead, ;do dai cua input
			  ADDR bytesWritten, ;so ki tu da ghi 
			  0	;ket thuc

		invoke ExitProcess, 0	;ket thuc qua trinh
	main endp ;ket thuc ham main
end main