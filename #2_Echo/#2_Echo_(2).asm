;#2.Echo_2
;Viet chuong trinh nhap doan van ban va in ra doan van ban do
include Irvine32.inc ; goi thu vien Irvine

inputSize = 32

.data ;khai bao du lieu 
	stdHandle HANDLE ?	;khai bao bien kich thuoc HANDLE
	input db inputSize dup(?), 0	;khai bao mang co do dai bang inputSize(=100) va cac phan tu chua duoc khoi tao ket thuc la NULL
	bytesRead dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao 
	bytesWritten dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao
.code
	
	main proc ;ham main 
		push STD_INPUT_HANDLE ;day (STD_INPUT_HANDLE = 0xFFFFFFF6h hoac -10d) len stack de lay handle cua thiet bi nhap chuan
		call GetStdHandle ;goi ham GetStdHanlde de lay handle va handle duoc luu trong thanh ghi eax
		mov stdHandle, eax ;luu gia tri handle vao bien stdHandle

		push 0 ;day 0 (NULL) len stack de bao hieu ket thuc hoat dong doc
		push offset bytesRead ;day dia chi cua bien bytesRead, bien nay dung de luu so ki tu da doc
		push 20h ;inputSize = 32d (20h) do dai toi da co the nhap cua input
		push offset input ;day dia chi cua bien input len stack, luu tru cac ki tu nhap tu console vao vi tri bo nho duoc chi dinh boi input
		push stdHandle ;day gia tri hanlde (dau vao chuan) len stack de ham ReadConsole biet nguon du lieu nhap tu dau 
		call ReadConsole ;goi ham ReadConsole de thuc thi

		push STD_OUTPUT_HANDLE ;day hang so STD_OUTPUT_HANDLE (-11d) dai dien cho handle cua thiet bi dau ra chuan 
		call GetStdHandle ;goi ham GetStdHandle de lay handle dau ra chuan duoc luu trong thanh ghi
		mov stdHandle, eax ;luu gia tri handle vao bien stdHandle

		push 0 ;day 0 (NULL) len stack de truyen vao tham so lpReserved trong ham WriteConsole
		push offset bytesWritten ;day dia chi cua bien bytesWritten (luu so luong ki tu ham da ghi ra console) 
		push bytesRead ;day bien bytesRead len stack do dai thuc su cua input
		push offset input ;day dia chi cua bien input len stack de ham WriteConsole biet noi lay du lieu in ra console
		push stdHandle ;day gia tri handle (dau ra chuan) len stack de ham WriteConsole biet thiet bi nao nhan ra du lieu ghi ra
		call WriteConsole ;goi ham WriteConsole de thuc thi in 

		invoke ExitProcess, 0 ;ket thuc qua trinh 
	main endp ;ket thuc ham main 
end main ;ket thuc chuong trinh