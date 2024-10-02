;#3.Uppercase
;Viet chuong trinh nhap vao mot chuoi van ban, in ra chuoi in hoa

include Irvine32.inc ; goi thu vien Irvine

inputSize = 32

.data 
	bytesWritten dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao
	input db inputSize dup(?) ;khai bao mang co do dai 32 chua duoc khoi tao gia tri
	bytesRead dd ?	;khai bao bien kich thuoc dd chua duoc khoi tao
	stdHandle HANDLE ? ;khai bao bien kich thuoc HANDLE chua duoc khoi tao
.code
	ucase proc ;ham uppercase
		mov esi, offset input ;truyen dia chi cua input vao thanh ghi esi
		L1:	mov al, [esi] ;lay ki tu hien tai tu dia chi ma thanh ghi esi dang tro toi
			cmp al, 0 ;so sanh ki tu hien tai voi ki tu null
			je L3 ;neu la ki tu null thi nhay toi L3 de thoat khoi vong lap va ket thuc ham
			cmp al, 61h ;so sanh ki tu hien tai voi ki tu 'a'
			jb L2 ;neu nho hon thi khong phai chu thuong va nhay den L2 
			cmp al, 7ah ;so sanh ki tu hien tai voi ki tu 'z'
			ja L2 ;neu lon hon thi khong phai chu thuong va nhay den L2 
			sub BYTE PTR [esi], 20h ;chuyen thanh ki tu in hoa 
		L2: inc esi ;tang con tro de tro ki tu tiep theo
			jmp L1 ;quay lai vong lap
		L3: ret ;ket thuc ham
	ucase endp 
	main proc ;ham main
		invoke GetStdHandle, STD_INPUT_HANDLE ;lay handle cua dau vao console (dung goi ham ReadConsole) duoc luu o eax
		mov stdHandle, eax ;truyen doi so de goi ham ReadConsole tu eax 

		invoke ReadConsole, ;goi ham de thuc thi 
			stdHandle, ;Handle de thuc thi lenh
			ADDR input, ;dia chi input de truyen du lieu tu ban phim
			inputSize, ;do dai cua input nhap vao toi da = 32
			ADDR bytesRead, ;do dai cua input duoc nhap vao
			0 ;ket thuc	

		call ucase ;goi ham chuyen doi 

		invoke GetStdHandle, STD_OUTPUT_HANDLE ;lay handle cua dau vao console dung de goi ham WriteConsole
		mov stdHandle, eax ;truyen doi so de goi ham WriteConsole tu eax 

		invoke WriteConsole, ;goi ham WriteConsole de thuc thi in chuoi
			 stdHandle, ;Handle de thuc thi lenh
			 ADDR input, ;dia chi chuoi in ra 
			 bytesRead, ;do dai cua chuoi in ra
			 ADDR bytesWritten, ;do dai thuc su cua du lieu
			 0 ;ket thuc

		invoke ExitProcess, 0 ;ket thuc qua trinh
	main endp ;ket thuc ham main
end main ;ket thuc chuong trinh