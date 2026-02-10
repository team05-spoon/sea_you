<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소검색</title>
<%
    request.setCharacterEncoding("UTF-8");  

    String inputYn = request.getParameter("inputYn");
    String roadFullAddr = request.getParameter("roadFullAddr");
    String jibunAddr = request.getParameter("jibunAddr");
    String zipNo = request.getParameter("zipNo");
%>
</head>

<script language="javascript">
function init(){
    var url = location.href;
    var confmKey = "devU01TX0FVVEgyMDI1MTIwMjE0MTE0MTExNjUyMjU=";
    var resultType = "4"; 

    var inputYn = "<%= (inputYn == null ? "" : inputYn) %>".trim();

    if(inputYn !== "Y"){
        document.form.confmKey.value = confmKey;
        document.form.returnUrl.value = url;
        document.form.resultType.value = resultType;
        document.form.action = "https://business.juso.go.kr/addrlink/addrLinkUrl.do"; 

        document.form.submit();
    } else {

        try{
            opener.jusoCallBack(
                "<%= (roadFullAddr == null ? "" : roadFullAddr) %>",
                "<%= (zipNo == null ? "" : zipNo) %>"
            );
        } catch(e){

            alert("주소 전달 중 오류: " + e);
        }
        self.close();
    }
}
</script>

<body onload="init();">
    <form id="form" name="form" method="post">
        <input type="hidden" id="confmKey" name="confmKey" value=""/>
        <input type="hidden" id="returnUrl" name="returnUrl" value=""/>
        <input type="hidden" id="resultType" name="resultType" value=""/>
    </form>
</body>
</html>
