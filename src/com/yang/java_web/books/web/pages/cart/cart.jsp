<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <%@ include file="/pages/common/head.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("a.deleteId").click(function () {
                return confirm("你确认删除【" + $(this).parent().parent().find("td:first").text() + "】嘛？")
            });

            $("#clearCart").click(function () {
                return confirm("你确认清空购物车嘛？")
            });

            $(".updateCount").change(function () {
                var name = $(this).parent().parent().find("td:first").text();
                var id = $(this).attr('bookId');
                var count = this.value;
                if ( confirm("你确定要将【" + name + "】商品修改数量为：" + count + " 吗?") ) {
                    location.href = "http://localhost:8080/books/cartServlet?action=updateCount&count="+count+"&id="+id;
                } else {
                    this.value = this.defaultValue;
                }
            });
        })
    </script>
</head>
<body>
<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">购物车</span>
    <%@ include file="/pages/common/login_success_menu.jsp" %>
</div>

<div id="main">
    <table>
        <tr>
            <td>商品名称</td>
            <td>数量</td>
            <td>单价</td>
            <td>金额</td>
            <td>操作</td>
        </tr>

        <c:if test="${empty sessionScope.cart.items}">
            <tr>
                <td colspan="5">
                    <a href="index.jsp">购物车为空!快去购物吧</a>
                </td>
            </tr>
        </c:if>

        <c:if test="${not empty sessionScope.cart.items}">
            <c:forEach items="${sessionScope.cart.items}" var="entry">
                <tr>
                    <td>${entry.value.name}</td>
                    <td>
                        <input type="text" style="width: 60px" class="updateCount" value="${entry.value.count}" bookId="${entry.value.id}">
                    </td>
                    <td>${entry.value.price}</td>
                    <td>${entry.value.totalPrice}</td>
                    <td>
                        <a href="cartServlet?action=deleteItems&id=${entry.value.id}" class="deleteId">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>

    <c:if test="${not empty sessionScope.cart.items}">
        <div class="cart_info">
            <span class="cart_span">购物车中共有<span class="b_count">${sessionScope.cart.totalCount}</span>件商品</span>
            <span class="cart_span">总金额<span class="b_price">${sessionScope.cart.totalPrice}</span>元</span>
            <span class="cart_span"><a href="cartServlet?action=clear" id="clearCart">清空购物车</a></span>
            <span class="cart_span"><a href="orderServlet?action=createOrder">去结账</a></span>
        </div>
    </c:if>
</div>

<%@include file="/pages/common/footer.jsp" %>
</body>
</html>