function checkForm(writeform){
	if(!writeform.book_kind.value){
	  alert("책의 분류를 선택하십시오");
	  writeform.book_kind.focus();
	  return false;
	}
	if(!writeform.book_title.value){
	  alert("책의 제목을 입력하십시오");
	  writeform.book_title.focus();
	  return false;
	}	
	if(!writeform.book_price.value){
	  alert("책의 가격을 입력하십시오");
	  writeform.book_price.focus();
	  return false;
	}  
	if(isNaN(writeform.book_price.value)){
	  alert("책의 가격은 숫자입니다");
	  writeform.book_price.focus();
	  writeform.book_price.value = "";
	  return false;
	}
	if(!writeform.book_count.value){
	  alert("책의 수량을 입력하십시오");
	  writeform.book_count.focus();
	  return false;
	}
	if(isNaN(writeform.book_count.value)){
	  alert("책의 수량은 숫자입니다");
	  writeform.book_count.focus();
	  writeform.book_count.value = "";
	  return false;
	}
	if(!writeform.author.value){
	  alert("저자를 입력하십시오");
	  writeform.author.focus();
	  return false;
	}	
	if(!writeform.publishing_com.value){
	  alert("출판사을 입력하십시오");
	  writeform.publishing_com.focus();
	  return false;
	}	
	if(!writeform.publishing_date.value){
		  alert("출판일을 입력하십시오");
		  writeform.publishing_date.focus();
		  return false;
	}
	if(!writeform.book_image.value){
		  alert("이미지를 입력하세요");
		  writeform.book_image.focus();
		  return false;
	}
	if(!writeform.book_content.value){
	  alert("책의 설명을 입력하십시오");
	  writeform.book_content.focus();
	  return false;
	}	
	if(!writeform.discount_rate.value){
	  alert("할인율을 입력하십시오");
	  writeform.discount_rate.focus();
	  return false;
	}
	if(isNaN(writeform.discount_rate.value)){
	  alert("할인율은 숫자입니다");
	  writeform.discount_rate.focus();
	  writeform.discount_rate.value = "";
	  return false;
	}	
	writeform.action = "bookRegisterPro.jsp";
    writeform.submit();	
 } 
 
 function updateCheckForm(writeform){
	if(!writeform.book_kind.value){
	  alert("책의 분류를 선택하십시오");
	  writeform.book_kind.focus();
	  return false;
	}
	if(!writeform.book_title.value){
	  alert("책의 제목을 입력하십시오");
	  writeform.book_title.focus();
	  return false;
	}	
	if(!writeform.book_price.value){
	  alert("책의 가격을 입력하십시오");
	  writeform.book_price.focus();
	  return false;
	} 
	if(isNaN(writeform.book_price.value)){
	  alert("책의 가격은 숫자입니다");
	  writeform.book_price.focus();
	  writeform.book_price.value = "";
	  return false;
	}
	if(!writeform.book_count.value){
	  alert("책의 수량을 입력하십시오");
	  writeform.book_count.focus();
	  return false;
	}
	if(isNaN(writeform.book_count.value)){
	  alert("책의 수량은 숫자입니다");
	  writeform.book_count.focus();
	  writeform.book_count.value = "";
	  return false;
	}
	if(!writeform.author.value){
	  alert("저자를 입력하십시오");
	  writeform.author.focus();
	  return false;
	}	
	if(!writeform.publishing_com.value){
	  alert("출판사을 입력하십시오");
	  writeform.publishing_com.focus();
	  return false;
	}	
	if(!writeform.book_content.value){
	  alert("책의 설명을 입력하십시오");
	  writeform.book_content.focus();
	  return false;
	}	
	if(!writeform.publishing_date.value){
		  alert("출판일을 입력하십시오");
		  writeform.publishing_date.focus();
		  return false;
	}
	if(!writeform.discount_rate.value){
		alert("할인율을 입력하십시오");
		writeform.discount_rate.focus();
		return false;
	}
	if(isNaN(writeform.discount_rate.value)){
	  alert("할인율은 숫자입니다");
	  writeform.discount_rate.focus();
	  writeform.discount_rate.value = "";
	  return false;
	}
	writeform.action = "bookUpdatePro.jsp";
    writeform.submit();	
 } 