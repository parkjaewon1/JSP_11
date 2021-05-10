<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%><html><head><title>로그인</title>
<link rel="stylesheet" type="text/css" href="../comm.css">
<style type="text/css">	body { text-align: center; 	} </style>
<script type="text/javascript">
	function chk() {
		if (!form1.id.value) { alert("ID 입력해야지, 알겠니 ?");
			form1.id.focus();	return false;		}
		if (!form1.passwd.value) {alert("패스워드 빼 먹었잖아 !");
			form1.passwd.focus(); return false;	}
		return true;
	}
</script></head><body>	<h2>관리자 로그인</h2>  
    <form method="post" action="managerLoginPro.jsp" name="form1" 
   		 onsubmit="return chk()">
	<table border="1" align="center">     	
      <tr><td>아이디</td><td>
      	<input type="text" name="id" maxlength="12"></td></tr>
      <tr><td>패스워드</td><td>
      	<input type="password" name="passwd" maxlength="12"></td></tr>
      <tr><td colspan="2"><input type="submit" value="로그인"></td></tr>
   </table>    </form></body></html>