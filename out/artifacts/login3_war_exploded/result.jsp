<%--
  Created by IntelliJ IDEA.
  User: yoshiji
  Date: 19/05/20
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.ArrayList" %>

<%
    ArrayList<ArrayList<String>> results = (ArrayList<ArrayList<String>>) request.getAttribute("results");

    // json 組み立てるか
    String jsProductArray = "[";
    for (ArrayList<String> data: results) {
        jsProductArray += "{name: '" + data.get(0) + "', categoryName: '" + data.get(1) + "', price: '" + data.get(2) + "'}, ";
    }
    jsProductArray += "]";
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <title>Title</title>
</head>
<body>
<div id="app">
    <v-app>
        <%--  ツールバー読み込み　--%>
        <%@ include file="components/toolbar.jsp" %>
        <v-container fluid grid-list-xl>
            <h2>検索結果: <%=results.size()%>件</h2>
            <a href="/login3_war_exploded">検索画面に戻る</a>
            <v-data-table
            :headers="headers"
            :items="<%=jsProductArray%>"
            class="elevation-1"
            >
                <template v-slot:items="props">
                    <td class="text-xs-left">{{ props.item.name }}</td>
                    <td class="text-xs-left">{{ props.item.categoryName }}</td>
                    <td class="text-xs-left">{{ props.item.price }}円</td>
                </template>
            </v-data-table>
        </v-container>
    </v-app>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.js"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            headers: [
                { text: '商品名', value: 'calories' },
                { text: 'カテゴリー名', value: 'fat' },
                { text: '価格', value: 'carbs' },
            ],
        }
    })
</script>
</body>
</html>
