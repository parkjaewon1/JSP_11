<%  
	String managerId ="";
	String path = application.getContextPath();
	// System.out.println("path = " + path);
    managerId = (String)session.getAttribute("managerId");
	if(managerId == null || managerId.equals("")){
       response.sendRedirect(path+"/manager/logon/managerLoginForm.jsp");
       return;
	} 
%>