;#4.Simple Addition
;Viet chuong trinh tinh tong 2 so nguyen duong nhap vao tu ban phim
include Irvine32.inc ; goi thu vien Irvine

inputSize = 32

.data ;khai bao du lieu 
	stdHandle HANDLE ?	;khai bao bien kich thuoc HANDLE
	num1 db inputSize dup(0) ;khai bao bien num1 luu du lieu so thu nhat 
	num2 db inputSize dup(0) ;khai bao bien num2 luu du lieu so thu hai
	result db inputSize dup(0) ;khai bao bien ket qua luu tru tong 2 so 
	byteRead1 dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao
	byteRead2 dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao
	byteWrite dd ? ;khai bao bien kich thuoc dd chua duoc khoi tao
	temp db 0 ;bien luu tru so nho
	count dd ? ;khai bao bien dem
.code
	addition proc
		push ebp ;day base poiter len stack
		mov ebp, esp ;khoi tao stack
		mov ecx, 0ah ;dua gia tri 0ah vao ecx
		push ecx ;day ecx len stack lam moc
		xor esi, esi ;xoa du lieu trong thanh ghi
		xor edi, edi ;xoa du lieu trong thanh ghi 
		xor ecx, ecx ;xoa du lieu trong thanh ghi
		xor edx, edx ;xoa du lieu trong thanh ghi 

		mov si, byteRead1 ;truyen do dai cua string num1
		mov di, byteRead2 ;truyen do dai cua string num2
		sub si, 3 ;giam do dai chuoi di 3 de loai bo cac ki tu khong phai so
		sub di, 3 ;giam do dai chuoi di 3 de loai bo cac ki tu khong phai so

		mov eax, [ebp + 12] ;truyen dia chi cua num1 vao thanh ghi eax
		mov ebx, [ebp + 8] ;truyen dia chi cua num2 vao thanh ghi ebx
		mov count, 0h ;gan gia tri bien count  = 0
		mov temp, 0 ;gan gia tri so nho bang 0

		L1: 
			cmp si, 0h ;so sanh do dai cua chuoi num1 voi 0
			jnz lp1 ;neu khong bang thi nhay den l1
			add count, 1 ;neu bang thi tang count len 1 don vi
		lp1:
			cmp di, 0h ;so sanh do dai cua chuoi num2 voi 0
			jnz lp2 ;neu khong bang thi nhay den l2
			add count, 1 ;neu bang thi tang count len 1 don vi
		lp2:
			cmp si,0h ; so sanh do dai cua chuoi num1 voi 0
			jge E1    ; neu lon hon hoac bang thi nhay den E1
			mov cl,0h ; cl = 0 
			jmp E2    ; nhay den E2
		E1: mov cl, BYTE PTR[eax + esi] ;truyen gia tri cua dia chi thu esi - 1 cua num1 vao cl
		E2: cmp di, 0h ;so sanh do dai cua chuoi num2 voi 0
			jge E3 ;neu lon hon hoac bang thi nhay den E3
			mov dl, 0h ;dl = 0
			jmp E4 ;nhay den E4
		E3: mov dl,BYTE PTR [ebx + edi] ;truyen gia tri cua dia chi thu edi - 1 cua num2 vao dl
		E4: cmp cl, 0h ;so sanh chu so chuan bi cong cua num1 voi 0
			jz L3 ;neu bang thi nhay qua L3
			cmp dl, 0h ;so sanh chu so chuan bi cong cua num1 voi 0
			jz L3 ;neu bang thi nhau den L3
		
		add cl, dl ;cong hai chu so
		add cl, temp ;cong them voi so nho neu co
		mov temp, 0 ;cong xong thi dat so nho = 0
		sub cl, 30h ;tru di 30h de thanh so trong bang ascii 
		cmp cl, 3Ah ;so sanh tong voi 3Ah
		jl L4 ;neu nho hon thi nhay qua L4
		mov temp, 1 ;neu khong thi cong so nho voi 1
		sub cl, 0Ah ;tru cl di 0Ah 
		
		L3: 
			add cl, dl ;cong 2 chu so
			add cl, temp ;cong them voi so nho neu co
			mov temp, 0 ;cong xong thi dat so nho bang 0
			cmp cl, 3Ah ;so sanh tong voi 3Ah
			jl L4 ;neu nho hon thi nhau den L4
			mov temp, 1 ;neu khong thi cong so nho voi 1
			sub cl, 0Ah ;tru cl di 0Ah
		L4: 
			push ecx ;day tong 2 chu so vua cong len stack
			cmp count, 2h ;so sanh count voi 2
			jz cancel ;neu bang thi nhay qua cancel
			dec si ;tru do dai cua num1 de lay so lien truoc
			dec di ;tru do dai cua num2 de lay so lien truoc
			jmp L1 ;nhay qua L1
		cancel:	cmp temp, 1 ;so sanh so nho voi 1
				jnz L5 ;neu khong co thi nhay qua L5
				mov cl, 1 ;con khong thi truyen 1 vao cl
				push ecx ;day tong 2 chu so vua cong len stack
		L5: xor ecx, ecx ;xoa du lieu
			xor edx, edx ;xoa du lieu
			xor ebx, ebx ;xoa du lieu 
			mov ebx, offset result ;truyen dia chi result vao ebx
		in: 
			cmp ecx, 0ah ;so sanh ecx voi 0ah 
			jz out ;neu bang ti nhay den out
			pop ecx ;lay du lieu tu dinh truyen vao ecx
			mov [ebx + edx], ecx ;truyen ecx vao dia chi cua cac phan tu chuoi result
			inc edx ;tang edx len 1 don vi
			jmp in ;nhay den in
		out:
			mov esp, ebp ;truyen ebp vao esp
			pop ebp ;lay gia tri tu dinh cua stack
			ret ;lenh return
	addition endp ;ket thuc ham addition

	main proc ;ham main 
		invoke GetStdHandle, STD_INPUT_HANDLE ;lay handle cua dau vao console (dung goi ham ReadConsole) duoc luu o eax
		mov stdHandle, eax ;truyen doi so de goi ham ReadConsole tu eax 

		invoke ReadConsole, ;goi ham de thuc thi 
			 stdHandle, ;Handle de thuc thi lenh
			 addr num1, ;dia chi num1 de truyen du lieu tu ban phim
			 inputSize, ;do dai cua input nhap vao toi da = 32
			 addr byteRead1, ;do dai thuc su cua num1 duoc nhap vao
			 0 

		invoke GetStdHandle, STD_INPUT_HANDLE ;lay handle cua dau vao console (dung goi ham ReadConsole) duoc luu o eax
		mov stdHandle, eax ;truyen doi so de goi ham ReadConsole tu eax 
		invoke ReadConsole,  ;goi ham de thuc thi
			 stdHandle, ;Handle de thuc thi lenh
			 addr num2,  ;dia chi num2 de truyen du lieu tu ban phim
			 inputSize,  ;do dai cua input nhap vao toi da = 32
			 addr byteRead2, ;do dai thuc su cua num1 duoc nhap vao
			 0
		
		push offset num1 ;day dia chi cua num1 len stack
		push offset num2 ;day dia chi cua num2 len stack
		call addition

		invoke GetStdHandle,STD_OUTPUT_HANDLE ; Lay Handle output de goi WriteConsole
		mov stdHandle, eax ; Truyen ma de goi WriteConsole

		invoke WriteConsole, ;goi ham de thuc thi in ra result
			 stdHandle, ;handle de thuc thi lenh
			 ADDR result,  ;dia chi cua result
			 inputSize, ;do dai cua result  
			 ADDR byteWrite, ;so ki tu da ghi 
			 0
		invoke ExitProcess, 0 ;ket thuc qua trinh
	main endp ;ket thuc ham main 
end main ;ket thuc chuong trinh