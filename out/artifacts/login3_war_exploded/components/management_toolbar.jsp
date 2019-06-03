<%--
  Created by IntelliJ IDEA.
  User: yoshiji
  Date: 19/05/27
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<v-toolbar dark>
    <v-toolbar-title>JV31 管理者画面</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
        <v-btn flat><a href="/login3_war_exploded">検索ページ(仮)</a></v-btn>
        <v-btn flat><a href="/login3_war_exploded/management/products/create">商品登録</a></v-btn>
        <v-btn flat><a href="/login3_war_exploded/management/categories/create">カテゴリー登録</a></v-btn>
    </v-toolbar-items>
</v-toolbar>
