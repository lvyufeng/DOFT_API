<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 18-3-12
  Time: 下午7:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java"  contentType="text/html; charset=UTF-8" %>

<html>
<body>
<h2>Hello World!</h2>



springmvc上传文件
<form name="form1" action="/doft/manage/dish/upload.do" method="post" enctype="multipart/form-data">
    <input type="file" name="upload_file" />
    <input type="submit" value="springmvc上传文件" />
</form>

</body>
</html>
